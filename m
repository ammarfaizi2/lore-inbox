Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbUDCXmy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 18:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbUDCXmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 18:42:54 -0500
Received: from CS2075.cs.fsu.edu ([128.186.122.75]:26653 "EHLO mail.cs.fsu.edu")
	by vger.kernel.org with ESMTP id S262049AbUDCXmw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 18:42:52 -0500
Message-ID: <005901c419d5$5ecd7c70$af7aa8c0@VALUED65BAD02C>
From: "Amit" <khandelw@cs.fsu.edu>
To: <karim@opersys.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <1080849830.91ac1e3f85274@system.cs.fsu.edu>	<406C79E4.1060700@opersys.com> <1081012426.5c22c66499b13@system.cs.fsu.edu>	<406F21CB.8070908@opersys.com> <1081026049.f64d5288b5aaa@system.cs.fsu.edu> <406F2851.6050304@opersys.com> <003b01c419d0$67e59e50$af7aa8c0@VALUED65BAD02C> <406F476D.8050002@opersys.com>
Subject: Re: kernel 2.4.16
Date: Sat, 3 Apr 2004 18:42:48 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Karim,
   The installation has gone through smoothly and I have managed to get an
linux-2.6.3 up and running with LTT.
I checked the documentation and it says that I need to do an insmod on the
tracer but I have compiled it as a part of the kernel. Now the documentation
says that I should execute the createdev.sh to create the devices. When I
execute that I get errors related to tracer. When I try to execute the
tracedaemon I get that relayfs is not mounted. Can you please tell me how to
go about doing the first part. After doing all this I want to run some test
cases and see how does LTT generate traces. Later on I would also like to
add rtai to this and see the traces from that too.

Thanks!
-Amit Khandelwal

PS. I would like to write down a small howto on this and pass it on to you
so that newbies like me can have a good ref. Thanks for the help.


----- Original Message ----- 
From: "Karim Yaghmour" <karim@opersys.com>
To: "Amit" <khandelw@cs.fsu.edu>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sent: Saturday, April 03, 2004 6:23 PM
Subject: Re: kernel 2.4.16


>
> Amit wrote:
> >    The patches got installed smoothly however, like in linux-2.4.19 this
> > time the "Kernel Tracing" option didn't come up when I did "make
xconfig". I
> > copied the CONFIG_TRACE=m from my .config of linux-2.4.19. I hope this
is
> > correct.
>
> No, this isn't the right way.
>
> You need to enable relayfs support in "File Systems"->"Pseudo
filesystems",
> then you will be able to select "General setup"->"Linux Trace Toolkit
support".
>
> Karim
> -- 
> Author, Speaker, Developer, Consultant
> Pushing Embedded and Real-Time Linux Systems Beyond the Limits
> http://www.opersys.com || karim@opersys.com || 1-866-677-4546
>


