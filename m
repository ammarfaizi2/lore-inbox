Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTIKRGb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 13:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbTIKRGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 13:06:31 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:47505 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261305AbTIKRG3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 13:06:29 -0400
Date: Thu, 11 Sep 2003 18:05:59 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: insecure@mail.od.ua, Michael Frank <mhf@linuxmail.org>,
       Yann Droneaud <yann.droneaud@mbda.fr>,
       fruhwirth clemens <clemens-dated-1063536166.2852@endorphin.org>,
       linux-kernel@vger.kernel.org,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: nasm over gas?
Message-ID: <20030911170559.GF29532@mail.jlokier.co.uk>
References: <20030904104245.GA1823@leto2.endorphin.org> <200309052028.37367.insecure@mail.od.ua> <m18yp0o2mq.fsf@ebiederm.dsl.xmission.com> <200309100034.58742.insecure@mail.od.ua> <m1znhbl8ws.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1znhbl8ws.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Although I tend to still prefer gcc 2.95 for the code size.  

I just compiled a small C function with GCC 3.2.2.  

With -O2, it had two completely redundant stack adjustment instructions.
With -Os, those instructions were gone and it was good code.

Why, oh why is -O2 still so lame after all these years? :)

-- Jamie
