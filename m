Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268076AbUHQCZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268076AbUHQCZg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 22:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268078AbUHQCZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 22:25:36 -0400
Received: from scl-ims.phoenix.com ([216.148.212.222]:59009 "EHLO
	scl-ims.phoenix.com") by vger.kernel.org with ESMTP id S268076AbUHQCZe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 22:25:34 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Re: Keyboard input ignored by 2.6.8
Date: Mon, 16 Aug 2004 19:25:45 -0700
Message-ID: <5F106036E3D97448B673ED7AA8B2B6B3015B698E@scl-exch2k.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Keyboard input ignored by 2.6.8
Thread-Index: AcSCHhdKMgeYrjdpRPCJN1PWfj8w1wB4wsBQ
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Tetsuji Rai" <badtrans666@yahoo.co.jp>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 Aug 2004 02:25:45.0779 (UTC) FILETIME=[806EB830:01C48401]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Today I compiled 2.6.8 on my Debian sarge with gcc-3.4(and tested with
>gcc-3.3 also), and found 2.6.8 didn't accept my keyboard input.   My
>keybaord is a usual PS/2 keyboard.  I don't know what's going 
>on.  I cannot
>even login.   Until today I have been using 2.6.7 without any 
>problem.   I
>attach my .config file as the attachment.
>
>Another (minor?) problem is when I compiled into usb stuff 
>into the 2.6.8
>kernel, it freezed on booting.  So I compiled usb stuff as 
>modules and it
>was solved.

Try this patch
http://www.mail-archive.com/linux-usb-devel%40lists.sourceforge.net/msg2
6993.html.
You need to specify "usb-handoff" as a kernel boot parameter.

Aleks.
