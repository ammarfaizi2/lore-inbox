Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262067AbSLMLtO>; Fri, 13 Dec 2002 06:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262296AbSLMLtO>; Fri, 13 Dec 2002 06:49:14 -0500
Received: from smtp.netcabo.pt ([212.113.174.9]:35965 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id <S262067AbSLMLtN>;
	Fri, 13 Dec 2002 06:49:13 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: =?iso-8859-1?q?Jo=E3o=20Seabra?= <seabra@aac.uc.pt>
To: linux-kernel@vger.kernel.org
Subject: Local APIC(?)+PIII mobile 
Date: Fri, 13 Dec 2002 11:56:11 +0000
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212131156.11262.seabra@aac.uc.pt>
X-OriginalArrivalTime: 13 Dec 2002 11:54:55.0446 (UTC) FILETIME=[73FF9F60:01C2A29E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

 I have an Asus S8600. 
 Mobile PIII 800Mhz + 192M RAM.
 If i select "Local APIC support on uniprocessors" the kernel while booting 
says there's no APIC present.Why?
 I know the same problem with some other laptops.
 Others detect it.
 

 At home my Athlon Tunderbird + Asus A7V133-C with local APIC enabled detects 
it but doesn seem to use it ... 

 cat /proc/interrupts
           CPU0
  0:     375529          XT-PIC  timer
  1:       7452          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:     113246          XT-PIC  bttv, eth0
  8:          2          XT-PIC  rtc
 10:     144373          XT-PIC  EMU10K1
 11:     382444          XT-PIC  nvidia
 12:     153864          XT-PIC  PS/2 Mouse
 14:      12346          XT-PIC  ide0
 15:         12          XT-PIC  ide1
NMI:          0
ERR:          0

Anyway why do I need local APIC :) ?What are the advantages?Links?

Thank you very much for your kindness

 Best Regards,

 João Seabra
