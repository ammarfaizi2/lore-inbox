Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293007AbSCJKEM>; Sun, 10 Mar 2002 05:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293008AbSCJKEC>; Sun, 10 Mar 2002 05:04:02 -0500
Received: from CPE-203-51-27-33.nsw.bigpond.net.au ([203.51.27.33]:13305 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S293007AbSCJKDr>; Sun, 10 Mar 2002 05:03:47 -0500
Message-ID: <3C8B2F7F.A371809D@eyal.emu.id.au>
Date: Sun, 10 Mar 2002 21:03:43 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: RAID magics gone...
In-Reply-To: <200203100914.KAA14394@cave.bitwizard.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff wrote:
> 
> Hi,
> 
> I have a machine with 4 160G disks in a raid-0 configuration. Now
> after upgrading the hardware, all of a sudden raidstart can't find the
> raid-superblocks anymore. Invalid magic.

A shot in the dark: any chance the new hardware sees a different
geometry so the RAID superblock location (which is at the end of
the disk) has shifted?

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
