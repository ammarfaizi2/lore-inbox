Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVBQXWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVBQXWf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 18:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVBQXUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 18:20:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:16535 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261208AbVBQXUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 18:20:15 -0500
Date: Thu, 17 Feb 2005 15:18:15 -0800
From: Greg KH <greg@kroah.com>
To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <gregkh@suse.de>,
       Frans Pop <aragorn@tiscali.nl>
Subject: Re: [PATCH 2.6] Add PCI quirk for SMBus on the Toshiba Satellite A40
Message-ID: <20050217231815.GD22195@kroah.com>
References: <20050213204639.1f0b4a27.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050213204639.1f0b4a27.khali@linux-fr.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2005 at 08:46:39PM +0100, Jean Delvare wrote:
> Hi all,
> 
> The Toshiba Satellite A40 laptop hides its SMBus device, much like a
> number of Asus boards reputedly do. This prevents access to the LM90
> hardware monitoring chip. This simple patch extends the PCI quirk used
> for the Asus and HP systems to this Toshiba laptop.
> 
> Please consider for merge into the PCI subsystem,
> thanks.
> 
> Signed-off-by: Frans Pop <aragorn@tiscali.nl>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Applied, thanks.

greg k-h

