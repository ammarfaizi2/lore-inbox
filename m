Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273203AbRIJFFW>; Mon, 10 Sep 2001 01:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273204AbRIJFFO>; Mon, 10 Sep 2001 01:05:14 -0400
Received: from web10408.mail.yahoo.com ([216.136.130.110]:36109 "HELO
	web10408.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S273203AbRIJFFE>; Mon, 10 Sep 2001 01:05:04 -0400
Message-ID: <20010910050525.97814.qmail@web10408.mail.yahoo.com>
Date: Mon, 10 Sep 2001 15:05:25 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Problem with i810 chipset 
To: kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Finally I can report that problem after many testings.

System: i810 graphic chipset, intel celeron 400Mhz;
128 Mb ram. Lucent software modem using lt-modem
driver version 5-99b

Linux: 2.4.9 ... together all ac series with new dri
module for XFree 4.1.0

XFree86 4.1.0 (slackware)

Problem description: system lockup when exitting
XFree86 when the internet connection is active.

How to reproduce:

connect to the internet using pppd. Do not disconnect.

then logout gnome or shuttdown/reboot the computer
using halt/reboot. usually I will get the text console
; but now I dont. no keys work ; no hard disk
activity, can not power off using computer button,
have to unplug the power cord.

If I disconnect ppp0 before logout gnome / or
halt/reboot, it doesn't happen.

If I compile the kernel but not choosing build new
modules for xfree 4.1.0 ; choose the old one (in ac
series), no problem at all

More infomation on request.







=====
S.KIEU

http://travel.yahoo.com.au - Yahoo! Travel
- Got Itchy feet? Get inspired!
