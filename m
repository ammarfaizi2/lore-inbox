Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbVLULTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbVLULTE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 06:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbVLULTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 06:19:04 -0500
Received: from havoc.gtf.org ([69.61.125.42]:22738 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932364AbVLULTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 06:19:03 -0500
Date: Wed, 21 Dec 2005 06:18:52 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Paul Rolland <rol@as2917.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Linux 2.4.32] SATA ICH5/PIIX and Combined mode
Message-ID: <20051221111852.GA7698@havoc.gtf.org>
References: <200512211110.jBLBALD24852@tag.witbe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512211110.jBLBALD24852@tag.witbe.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 12:10:22PM +0100, Paul Rolland wrote:
> I have a machine with two SATA HDD, and one PATA CDRom.
> Bios is configured for combined mode, and installing a RedHat ES3
> (Kernel 2.4.21-ELsmp) is fine, the two HDD are up, the installation
> is fine and the CDRom is working.
> 
> Then, upgrading to a vanilla 2.4.32, the ata_piix.c file contains
> a "combined mode not supported" and booting the machine hangs, as
> no VFS are up for root device.
> 
> Of course, I can disable the Combined setup in the BIOS, then I have
> my two HDD, but no CDRom... 
> 
> What is the "trick" to have a 2.4.32 be able to do what a 2.4.21 was
> doing ?

Apply all the Red Hat-specific patches that you ditched, when you
switched to a vanilla kernel...  The patch that supported combined
mode for you is in there.

	Jeff



