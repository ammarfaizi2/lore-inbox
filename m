Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbTJIXzz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 19:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbTJIXzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 19:55:55 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:23507 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id S262667AbTJIXzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 19:55:54 -0400
Date: Fri, 10 Oct 2003 01:55:53 +0200
From: Domen Puncer <domen@coderock.org>
Subject: Re: 3c59x on 2.6.0-test3->test6 slow
In-reply-to: <Pine.LNX.4.53.0310091904400.3679@montezuma.fsmlabs.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <200310100155.53205.domen@coderock.org>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5.4
References: <200310061529.56959.domen@coderock.org>
 <200310091049.18595.domen@coderock.org>
 <Pine.LNX.4.53.0310091904400.3679@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 of October 2003 01:10, Zwane Mwaikambo wrote:
> On Thu, 9 Oct 2003, Domen Puncer wrote:
> > > > eth0: negotiated 100baseTx-FD, link ok
> > > > when it is ok (reloaded -test2 module)
> > >
> > > What does mii-tool -r do?
> >
> > Doesn't help, neither do -R or -F.
>
> Ok to recap, backing out the WOL change fixes things? If not, can you
> isolate which kernel version it is?

-after the WOL change... works slow, no matter what i do.
-before the WOL change... works slow, but rmmod/modprobe fixes this.

Will try with drivers from older kernels, when i wake up.

