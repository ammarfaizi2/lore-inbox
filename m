Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316896AbSFVUMw>; Sat, 22 Jun 2002 16:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316893AbSFVUMv>; Sat, 22 Jun 2002 16:12:51 -0400
Received: from ns3.maptuit.com ([204.138.244.3]:57874 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S316892AbSFVUMu>;
	Sat, 22 Jun 2002 16:12:50 -0400
Message-ID: <3D14D9F1.8B88668F@torque.net>
Date: Sat, 22 Jun 2002 16:11:29 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.24 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: David Brownell <david-b@pacbell.net>,
       Nick Bellinger <nickb@attheoffice.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] /proc/scsi/map
References: <Pine.LNX.4.44.0206221943320.8911-100000@serv>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> 
> Hi,
> 
> On Sat, 22 Jun 2002, David Brownell wrote:
> 
> > Why shouldn't there be a $DRIVERFS/net/ipv4@10.42.135.99/... style hookup
> > for iSCSI devices?  Using whatever physical addressing the kernel uses
> > there, which I assume wouldn't necessarily be restricted to ipv4.
> 
> iSCSI devices are uniqely identified by its name. An iSCSI device can be
> reachable at multiple ip numbers or they can even change dynamically.

Roman,
Trying to clear up the nomenclature here, according to SAM-2
( www.10.org ) target ports have mandatory "identifiers"
and optional "names". The WWUI in iSCSI is part of the
target _identifier_. SAM-2 is pretty vague about "names"
but it does note that for a logical unit, its _name_
may be reported in the Device Identification VPD page in
an INQUIRY. 


Doug Gilbert
