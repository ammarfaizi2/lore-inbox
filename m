Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282687AbRLIC5H>; Sat, 8 Dec 2001 21:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282922AbRLIC45>; Sat, 8 Dec 2001 21:56:57 -0500
Received: from mta02ps.bigpond.com ([144.135.25.134]:38104 "EHLO
	mta02ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S282687AbRLIC4k>; Sat, 8 Dec 2001 21:56:40 -0500
Message-ID: <3C12D227.2595EEC1@yahoo.com>
Date: Sun, 09 Dec 2001 13:53:27 +1100
From: YH <yh86us@yahoo.com>
Reply-To: yh86us@yahoo.com
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: device video0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a quickcam module linked to /dev/video0. It was fine to run modprobe
char-major-81-0, but the /dev/video0 (major=81, minor=0) cannot be opened, the
errno=19 (No such device). There was no error of loading module in
/var/log/messages. 

My understand is that calling open() to open video0, the system invokes
"modprobe char-major-81-0", if the module (alias char-major-81-0) can be
loaded, the device should be opened. What was I missing here? How can I
further diagnose it?

System: Dell Pentium III, Kernel 2.4.2-2 in RH 7.1 (no permission problem, I
am in both root and users. No problem with the USB and videodev module)

Hardware: logitech quickcam express webcam (USB) (no problem running it on the
Window of my dual-boot platform.)

Thank you.

yh
