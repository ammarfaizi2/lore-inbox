Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266109AbUALKVW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 05:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266099AbUALKVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 05:21:22 -0500
Received: from madrid10.amenworld.com ([62.193.203.32]:36877 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S266109AbUALKVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 05:21:09 -0500
Date: Mon, 12 Jan 2004 11:20:39 +0100
From: DervishD <raul@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: SMP or UP???
Message-ID: <20040112102039.GF18338@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :))

    I have an used Gigabyte GA-7ZXE mobo, with chipset VIA KT133A,
wearing a Duron 1000 processor, since December. AFAIK this mobo is
uniprocessor (it has only a socket, that should be a good
evidence...), but when booting I get these messages (I just show
those relevant to the issue):

kernel: Linux version 2.4.21 (root@DervishD) (gcc version 3.2.2) #1 Wed Jul 2 17:25:21 CEST 2003
kernel: found SMP MP-table at 000fb210

    What, SMP table?

kernel: hm, page 000fb000 reserved twice.
kernel: hm, page 000fc000 reserved twice.
kernel: hm, page 000f5000 reserved twice.
kernel: hm, page 000f6000 reserved twice.
kernel: Intel MultiProcessor Specification v1.1
kernel:     Virtual Wire compatibility mode.

    Is this chipset then SMP capable? 

kernel: OEM ID: VIA      Product ID: KT133        APIC at: 0xFEE00000
kernel: Processor #0 Pentium(tm) Pro APIC version 17

    What Pentium? This is an AMD mobo :??

kernel: I/O APIC #2 Version 17 at 0xFEC00000.
kernel: Enabling APIC mode: Flat.?Using 1 I/O APICs
kernel: Processors: 1

    When booting some distros, like Knoppix, I have an 'Error: only
one processor found' log message.

kernel: Initializing CPU#0
kernel: Detected 1000.077 MHz processor.
kernel: Calibrating delay loop... 1992.29 BogoMIPS
kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
kernel: CPU: L2 Cache: 64K (64 bytes/line)
kernel: CPU: AMD Duron(tm) stepping 00

    Well, finally my Duron got detected...

    This is not an issue, because the system seems to work OK, but
for me is very strange and I'm not sure wether this may cause
problems or not...

    Thanks in advance :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
