Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265788AbUBGFzt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 00:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266650AbUBGFzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 00:55:49 -0500
Received: from ruby.getonit.net.au ([210.8.120.221]:24713 "EHLO
	ruby.getonit.net.au") by vger.kernel.org with ESMTP id S265788AbUBGFzs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 00:55:48 -0500
Message-ID: <01cf01c3ed3f$069c1240$8c02a8c0@timtopxp>
From: "Tim Warnock" <timoid@getonit.net.au>
To: <linux-kernel@vger.kernel.org>
Subject: p4ht time accelleration
Date: Sat, 7 Feb 2004 15:55:44 +1000
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

Hi list,

i have a box running 2.4.24 (its been doing this since the box was put into
place on 2.4.21)

basically:

cat /proc/driver/rtc ; sleep 10; cat /proc/driver/rtc
rtc_time        : 20:13:50
rtc_date        : 2004-02-07
rtc_epoch       : 1900
alarm           : 00:00:00
DST_enable      : no
BCD             : yes
24hr            : yes
square_wave     : no
alarm_IRQ       : no
update_IRQ      : no
periodic_IRQ    : no
periodic_freq   : 1024
batt_status     : okay


rtc_time        : 20:13:53
rtc_date        : 2004-02-07
rtc_epoch       : 1900
alarm           : 00:00:00
DST_enable      : no
BCD             : yes
24hr            : yes
square_wave     : no
alarm_IRQ       : no
update_IRQ      : no
periodic_IRQ    : no
periodic_freq   : 1024
batt_status     : okay

the os time accellerates into the future but the rtc time stays normal...

is it software, hardware or what? i dont know. i dunno who to ask for
help hence the post...

the box is a p4ht 2.6 ibm think center

tia

tim
