Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbUCSJCT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 04:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbUCSJCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 04:02:19 -0500
Received: from main.gmane.org ([80.91.224.249]:15524 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261969AbUCSJCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 04:02:15 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Patrick Beard" <patrick@scotcomms.co.uk>
Subject: Re: Kernel 2.6.3 i810fb Grub Boot Loader
Date: Fri, 19 Mar 2004 09:02:12 -0000
Message-ID: <c3ecuk$768$1@sea.gmane.org>
References: <c3c5f7$19a$1@sea.gmane.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: gateway.scotcomms.co.uk
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Patrick Beard" <patrick@scotcomms.co.uk> wrote in message
news:c3c5f7$19a$1@sea.gmane.org...
> Hi,
> Not sure if this is a i810fb issue or not (appologies if its not)
>
> I've been using the i810fb in kernel 2.6.x with no problems on Debian
> sarge.
> Below is the append line I used in Lilo;
>
video=i810fb:vram:2,xres:1024,yres:768,bpp:16,hsync1:30,hsync2:55,vsync1
> :50,vsync2:85,accel,mtrr

HI again,
Removing the accel option has resolved this. Not sure why I never saw
this problem with lilo.
--
Paddy



