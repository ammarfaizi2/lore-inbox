Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbTJDLyJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 07:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbTJDLyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 07:54:09 -0400
Received: from mail.convergence.de ([212.84.236.4]:2285 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261984AbTJDLyD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 07:54:03 -0400
Message-ID: <3F7EB4CC.8020606@linuxtv.org>
Date: Sat, 04 Oct 2003 13:53:48 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH[[2.4] Documentation cleanup: ioctl-number.txt
Content-Type: multipart/mixed;
 boundary="------------040804040103070602010504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040804040103070602010504
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello Marcelo,

please apply the following small patch against 2.4 which removes two 
bogus informations from "ioctl-number.txt":

1) The DVD decoder driver was never finished and never released. I 
recently removed these informations from our website -- most of the work 
that was freely available has gone into projects like libdvdread and 
libdvdnav.

2) There never was a "saa7146 driver" from Philips officially. Instead, 
in 2.6. my saa7146 driver was included which drives various analog TV 
cards and various DVB cards through Video4Linux-2.

Thanks!

Michael Hunold
(LinuxTV.org CVS maintainer)

--------------040804040103070602010504
Content-Type: text/plain;
 name="ioctl-number.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ioctl-number.diff"

diff -ura linux/Documentation/ioctl-number.txt linux-new/Documentation/ioctl-number.txt
--- linux/Documentation/ioctl-number.txt	2003-09-20 21:47:54.000000000 +0200
+++ linux-new/Documentation/ioctl-number.txt	2003-10-04 13:35:50.000000000 +0200
@@ -171,10 +171,6 @@
 					<mailto:buk@buks.ipn.de>
 0xA0	all	linux/sdp/sdp.h		Industrial Device Project
 					<mailto:kenji@bitgate.com>
-0xA2    00-0F   DVD decoder driver      in development:
-                                        <http://linuxtv.org/dvd/api/>
-0xA3	00-1F	Philips SAA7146 dirver	in development:
-					<mailto:Andreas.Beckmann@hamburg.sc.philips.com>
 0xA3	80-8F	Port ACL		in development:
 					<mailto:tlewis@mindspring.com>
 0xA3	90-9F	linux/dtlk.h

--------------040804040103070602010504--

