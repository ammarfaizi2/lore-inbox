Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280740AbRKGCLU>; Tue, 6 Nov 2001 21:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280758AbRKGCLL>; Tue, 6 Nov 2001 21:11:11 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:6668
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S280756AbRKGCLD>; Tue, 6 Nov 2001 21:11:03 -0500
Date: Tue, 6 Nov 2001 21:18:34 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: ess maestro 2e card has tons of static
Message-ID: <20011106211834.A3844@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel 2.4.4 to 2.4.14 all exibit this problem.  2.4.1 does not

While playing anything through the sound, it will produce intermittent
static with the sounds being played.

This is an NEC Versa SX notebook.

dmesg output
maestro: Configuring ESS Maestro 2E found at IO 0xEC00 IRQ 5
maestro:  subvendor id: 0x80581033
maestro: not attempting power management.
maestro: AC97 Codec detected: v: 0x414b4d00 caps: 0x0 pwr: 0xf
maestro: 1 channels configured.
maestro: version 0.15 time 21:54:00 Nov  6 2001

lspci -v
00:04.0 Multimedia audio controller: ESS Technology ES1978 Maestro 2E (rev 10)
        Subsystem: NEC Corporation ES1978 Maestro-2E Audiodrive
        Flags: bus master, medium devsel, latency 64, IRQ 5
        I/O ports at ec00 [size=256]
        Capabilities: <available only to root>

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
