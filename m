Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315528AbSFYPOb>; Tue, 25 Jun 2002 11:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315529AbSFYPOb>; Tue, 25 Jun 2002 11:14:31 -0400
Received: from adsl-66-136-202-174.dsl.austtx.swbell.net ([66.136.202.174]:40840
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S315528AbSFYPOa>; Tue, 25 Jun 2002 11:14:30 -0400
Subject: [Possibly OT] Qlogic and greater than 8 luns.
From: Austin Gonyou <austin@digitalroadkill.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 25 Jun 2002 10:13:26 -0500
Message-Id: <1025018006.25139.7.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If anyone out there has had any issues with QLA2200's and a Cu FC1
array(PV660F in this case), and seeing > than 8 luns with 2.4.x please
help me understand what's missing.


I use GRUB for booting, I've flashed the cards to support > 8 luns on
the HBA, Windows can see all the LUNs but Linux cannot. I've worked with
several tech support people, and tried all the supported driver versions
from Qlogic. Still, linux only sees 8 LUNSs(0-7). 

This is a direct attach scenario. I've also added the max_scsi_luns=128
to my GRUB boot string.  If anyone knows if there's a ql2xopts= setting
to enable Driver LUN support > 8 LUNs, I'd greatly appreciate any help.
I've been working on this for nearly 2 days straight and my boss is
putting pressure on me to get this done sooner than promised. 

TIA. 
-- 
Austin Gonyou <austin@digitalroadkill.net>
