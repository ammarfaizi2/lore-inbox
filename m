Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136540AbREDWSg>; Fri, 4 May 2001 18:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136538AbREDWSZ>; Fri, 4 May 2001 18:18:25 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:10256 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136537AbREDWST>; Fri, 4 May 2001 18:18:19 -0400
Subject: Re: Setting kernel options at compile time.
To: chip@innovates.com (Chip Schweiss)
Date: Fri, 4 May 2001 23:21:31 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <H00000650007236c.0989014582.dublin.innovates.com@MHS> from "Chip Schweiss" at May 04, 2001 05:16:22 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vnx8-000893-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> a diskless system.  I can get the kernel loaded and running.  The 
> problem is the i810 needs the kernel parameter "mem=xxxM" set to tell 
> the kernel how much memory the system has since the on the i810 the 
> kernel doesn't know how much was taken for video.

The BIOS itself marks off the block of memory used in VGA emulation
modes. The agpgart driver then gets used by X11 to allocate for the other
modes it uses.  At least for every i810 device I have ever seen.

Alan

