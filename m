Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265201AbTLROzc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 09:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265206AbTLROzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 09:55:32 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:8681 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S265201AbTLROzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 09:55:31 -0500
Date: Thu, 18 Dec 2003 15:55:27 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: SCSI AM53C974 driver missing in 2.6.0?
Message-ID: <20031218145527.GN19831@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

% lspci -v
00:0b.0 SCSI storage controller: Advanced Micro Devices [AMD] 53c974 [PCscsi] (rev 10)
        Flags: bus master, stepping, medium devsel, latency 70, IRQ 10
        I/O ports at b800 [size=128]
        Expansion ROM at <unassigned> [disabled] [size=64K]
	
in 2.4.x we've been using 
CONFIG_SCSI_AM53C974=m

2.6.0 doesn't seem to have any support for that specific SCSI
controller. What now? Aternatives?

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
Referat V a - Kommunikationsnetze -             AIM.  ralfpostfix
