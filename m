Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbTIGTc1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 15:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbTIGTcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 15:32:16 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:911 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S261493AbTIGTcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 15:32:09 -0400
Date: Sun, 7 Sep 2003 20:30:30 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: insecure@mail.od.ua, Michael Frank <mhf@linuxmail.org>,
       Yann Droneaud <yann.droneaud@mbda.fr>,
       fruhwirth clemens <clemens-dated-1063536166.2852@endorphin.org>,
       linux-kernel@vger.kernel.org,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: nasm over gas?
Message-ID: <20030907193030.GA21936@mail.jlokier.co.uk>
References: <20030904104245.GA1823@leto2.endorphin.org> <200309050128.47002.insecure@mail.od.ua> <200309052058.11982.mhf@linuxmail.org> <200309052028.37367.insecure@mail.od.ua> <m18yp0o2mq.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m18yp0o2mq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Actually it is no as simple as that.  With the instruction that uses
> %edi following immediately after the instruction that populates it you cannot
> execute those two instructions in parallel.  So the code may be slower.  The
> exact rules depend on the architecture of the cpu.

I remember inserting a "nop" into a loop and it went significantly
faster on a Pentium Pro :)

> If you concentrate on those handful of places where you need to
> optimize that is reasonable.  Beyond that there simply are not the
> developer resources to do good assembly.  And things like algorithmic
> transformations in assembly are an absolute nightmare.  Where they are
> quite simple in C.

If we had enough developer resources to write the whole thing in good
assembly, then for _sure_ we'd have enough to write a perfect compiler!

I would argue that the most powerful algorithmic transformations are a
nightmare in C, too.  Less so, though.

-- Jamie
