Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265845AbTIERpv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 13:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbTIERpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 13:45:50 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:33475 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S265845AbTIERpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 13:45:49 -0400
Date: Fri, 5 Sep 2003 19:45:08 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: insecure <insecure@mail.od.ua>
Cc: Michael Frank <mhf@linuxmail.org>, Yann Droneaud <yann.droneaud@mbda.fr>,
       fruhwirth clemens <clemens-dated-1063536166.2852@endorphin.org>,
       linux-kernel@vger.kernel.org
Subject: Re: nasm over gas?
Message-ID: <20030905174508.GA24951@wohnheim.fh-wedel.de>
References: <20030904104245.GA1823@leto2.endorphin.org> <200309050128.47002.insecure@mail.od.ua> <200309052058.11982.mhf@linuxmail.org> <200309052028.37367.insecure@mail.od.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200309052028.37367.insecure@mail.od.ua>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 September 2003 20:28:37 +0300, insecure wrote:
> 
> What gives you an impression that anyone is going to rewrite linux in asm?
> I _only_ saying that compiler-generated asm is not 'good'. It's mediocre.

Depends.  A couple weeks back, I've entered the Linuxtag coding
contest with a friend.  The objective was to optimize some matrix
multiplication.  We've produced *much* faster code than anyone who
tried to do it in assembler and we entered the contest during a slow
hour, when it was half over.

Given infinite developer time, you can create better assembler code
than the compiler can.  But with limited time, it is a challenge.
Plus the code isn't automagically updated to new cpus simply by
recompiling.

So in the real world, compiler generated assembler is not perfect, but
it is still faster than what most human would come up with even if
they had the time.

Jörn

-- 
Public Domain  - Free as in Beer
General Public - Free as in Speech
BSD License    - Free as in Enterprise
Shared Source  - Free as in "Work will make you..."
