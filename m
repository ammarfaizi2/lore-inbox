Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281076AbRKKVSt>; Sun, 11 Nov 2001 16:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281072AbRKKVSh>; Sun, 11 Nov 2001 16:18:37 -0500
Received: from Olivier.PK.WAU.NL ([137.224.145.16]:38148 "EHLO
	olivier.pk.wau.nl") by vger.kernel.org with ESMTP
	id <S281076AbRKKVSZ>; Sun, 11 Nov 2001 16:18:25 -0500
Date: Sun, 11 Nov 2001 22:18:18 +0100
To: linux-kernel@vger.kernel.org
Subject: FPU emulator: unknown prefix byte 0x00
Message-ID: <20011111221818.A21246@olivier>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
From: lists@olivier.pk.wau.nl (List Account)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When booting a 2.4.7 kernel on an old 486 sx laptop I have, I get the following error (non recoverable) when fsck is run during startup:

FPU emulator: unknown prefix byte 0x00, probably due to self-modifying code (emulation impossible)
FPU ........: internal error type 0x0126
At 00000023:0206
 SW: b=1 st=0 es=1 sf=1 cc=0010 ef=111111
 CW: ic=0 rc=00 pc=11 ien=0     ef=111111

When booting init=/bin/bash I can run some commands, but some fail, like lilo, df, fsck

The laptop is running Debian Woody
The laptop is a non-brand (Trust ?!? anybody???) 486 sx with 4mb ram and a 123mb HD

Does anybody have a clue why this laptop is not working?

thanks,
	Olivier

 
