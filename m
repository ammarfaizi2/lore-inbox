Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272929AbTHIQWP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 12:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272932AbTHIQWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 12:22:15 -0400
Received: from h234n2fls24o900.bredband.comhem.se ([217.208.132.234]:61403
	"EHLO oden.fish.net") by vger.kernel.org with ESMTP id S272929AbTHIQWL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 12:22:11 -0400
Date: Sat, 9 Aug 2003 18:24:29 +0200
From: Voluspa <lista1@telia.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test3 Make defconfig or menuconfig - unchoosables
Message-Id: <20030809182429.094de20b.lista1@telia.com>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Looking for the fabled but hard to locate "ikconfig":

root:loke:/usr/src/test/linux# make defconfig >fel.log
./arch/i386/defconfig:22: trying to assign nonexistent symbol IKCONFIG
./arch/i386/defconfig:23: trying to assign nonexistent symbol
IKCONFIG_PROC
./arch/i386/defconfig:70: trying to assign nonexistent symbol X86_SSE2
./arch/i386/defconfig:183: trying to assign nonexistent symbol PNP_NAMES
./arch/i386/defconfig:184: trying to assign nonexistent symbol PNP_CARD
./arch/i386/defconfig:324: trying to assign nonexistent symbol
SCSI_EATA_DMA
./arch/i386/defconfig:336: trying to assign nonexistent symbol
SCSI_NCR53C7xx
./arch/i386/defconfig:338: trying to assign nonexistent symbol
SCSI_NCR53C8XX
./arch/i386/defconfig:361: trying to assign nonexistent symbol
SCSI_PCMCIA
./arch/i386/defconfig:395: trying to assign nonexistent symbol FILTER
./arch/i386/defconfig:544: trying to assign nonexistent symbol
NET_PCMCIA_RADIO
./arch/i386/defconfig:663: trying to assign nonexistent symbol INTEL_RNG
./arch/i386/defconfig:664: trying to assign nonexistent symbol AMD_RNG
./arch/i386/defconfig:678: trying to assign nonexistent symbol AGP3

Mvh
Mats Johannesson
