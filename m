Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267039AbTCECeV>; Tue, 4 Mar 2003 21:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267072AbTCECeU>; Tue, 4 Mar 2003 21:34:20 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:55306 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267039AbTCECeU>; Tue, 4 Mar 2003 21:34:20 -0500
Date: Wed, 5 Mar 2003 03:44:46 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: IDE DMA/VIA woes on SuSE 2.4.19-167
Message-ID: <20030305024446.GA13870@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have some issues here:

Plextor PX-W4824TA 1.03 as hdc (no hdd)
VIA KT133

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 32
        I/O ports at ffa0 [size=16]
        Capabilities: [c0] Power Management version 2

When I try to enable DMA (hdparm -d1 or hdparm -d1 -X66), hdparm -tT
chokes, SuSE k_athlon-2.4.19-167. FreeBSD-5 (with atapicam) is fine and
uses UDMA33.

SuSE's kernel seems to be fine on a different hardware (VIA KT333 +
Toshiba SD-M1612).

I've tried 2.4.21-pre5 which crashes on boot, I haven't yet been able to
go fishing for the Ooops and decode it (I have serial console here, so
it's just a matter of finding the time to do that).

ide-scsi makes no difference (not that I had expected that).

Which kernel version should I try next before thinking about this for
longer?

-- 
Matthias Andree
