Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTLSR6L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 12:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbTLSR6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 12:58:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:31124 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263185AbTLSR6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 12:58:08 -0500
Date: Fri, 19 Dec 2003 09:56:47 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SCSI AM53C974 driver missing in 2.6.0?
Message-Id: <20031219095647.18648118.rddunlap@osdl.org>
In-Reply-To: <20031218145527.GN19831@charite.de>
References: <20031218145527.GN19831@charite.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Dec 2003 15:55:27 +0100 Ralf Hildebrandt <Ralf.Hildebrandt@charite.de> wrote:

| % lspci -v
| 00:0b.0 SCSI storage controller: Advanced Micro Devices [AMD] 53c974 [PCscsi] (rev 10)
|         Flags: bus master, stepping, medium devsel, latency 70, IRQ 10
|         I/O ports at b800 [size=128]
|         Expansion ROM at <unassigned> [disabled] [size=64K]
| 	
| in 2.4.x we've been using 
| CONFIG_SCSI_AM53C974=m
| 
| 2.6.0 doesn't seem to have any support for that specific SCSI
| controller. What now? Aternatives?

Kurt Garloff <garloff@suse.de>
and Guennadi Liakhovetski <g.liakhovetski@gmx.de>
have made some recent patches for this driver.
It was discussed on the linux-scsi@vger.kernel.org mailing list.

Kurt, Guennadi:  Is there a current patch posted somewhere?

--
~Randy
MOTD:  Always include version info.
