Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318107AbSGWPSX>; Tue, 23 Jul 2002 11:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318152AbSGWPSX>; Tue, 23 Jul 2002 11:18:23 -0400
Received: from mail.uklinux.net ([80.84.72.21]:14090 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S318107AbSGWPSW>;
	Tue, 23 Jul 2002 11:18:22 -0400
Envelope-To: <linux-kernel@vger.kernel.org>
Message-ID: <000901c2325d$089190a0$21228013@local>
From: "Marconi" <mail@marconi.uklinux.net>
To: <linux-kernel@vger.kernel.org>
Subject: Linux Kernel 2.4.19rc3 PROBLEM
Date: Tue, 23 Jul 2002 16:24:25 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The total memory values reported in /proc/meminfo are different in the
latest 2.4.19 kernel (RC3), does anyone know why?

Differences of 2.4.18 /proc/meminfo and 2.4.19rc3 /proc/meminfo (see *)

          total:            used:          free:             shared:
buffers:      cached:                        total:           used:
free:             shared:    buffers:   cached:
Mem:  525393920   520925184  4468736        0            23011328   36332339
Mem:  527450112  99909632 427540480     0            4526080  54579200
Swap: 1257181184  8806400     1248374784
Swap: 1257181184             0 1257181184
MemTotal:       513080 kB
*   MemTotal:       515088 kB
MemFree:          4364 kB
MemFree:        417520 kB
MemShared:           0 kB
MemShared:           0 kB
Buffers:         22472 kB
Buffers:          4420 kB
Cached:         352676 kB
Cached:          53300 kB
SwapCached:       2132 kB
SwapCached:          0 kB
Active:         180604 kB
Active:          19224 kB
Inactive:       262696 kB
Inactive:        56860 kB
HighTotal:           0 kB
HighTotal:           0 kB
HighFree:            0 kB
   HighFree:            0 kB
LowTotal:       513080 kB
*   LowTotal:       515088 kB
LowFree:          4364 kB
LowFree:        417520 kB
SwapTotal:     1227716 kB
SwapTotal:     1227716 kB
SwapFree:      1219116 kB
SwapFree:      1227716 kB

Regards,
Andy

