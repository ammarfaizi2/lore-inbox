Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265336AbSL2AnP>; Sat, 28 Dec 2002 19:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265628AbSL2AnP>; Sat, 28 Dec 2002 19:43:15 -0500
Received: from frank.gwc.org.uk ([212.240.16.7]:61869 "EHLO frank.gwc.org.uk")
	by vger.kernel.org with ESMTP id <S265336AbSL2AnO>;
	Sat, 28 Dec 2002 19:43:14 -0500
Date: Sun, 29 Dec 2002 00:51:31 +0000 (GMT)
From: Alistair Riddell <ali@gwc.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre2: CPU0 handles all interrupts
In-Reply-To: <200212281056.58419.hans.lambrechts@skynet.be>
Message-ID: <Pine.LNX.4.44.0212290047390.20942-100000@frank.gwc.org.uk>
X-foo: bar
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

me three, I get the following /proc/interrupts:
           CPU0       CPU1
  0:   54567949          0    IO-APIC-edge  timer
  1:          2          0    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  3:    3053053          0    IO-APIC-edge  serial
 14:   13055425          0    IO-APIC-edge  ide0
 15:   21991640          0    IO-APIC-edge  ide1
 24:  147016482          0   IO-APIC-level  eth0
 26:    1720744          0   IO-APIC-level  aic7xxx
 27:         16          0   IO-APIC-level  aic7xxx
NMI:          0          0
LOC:   54568206   54570366
ERR:          0
MIS:          0

lspci:
00:00.0 Host bridge: Relience Computer CNB20HE (rev 05)
00:00.1 Host bridge: Relience Computer CNB20HE (rev 05)

Let me know if I can provide any further info.

-- 
Alistair Riddell - BOFH
IT Manager, George Watson's College, Edinburgh
Tel: +44 131 446 6070    Fax: +44 131 452 8594
Microsoft - because god hates us

