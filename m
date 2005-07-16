Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbVGPPjC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVGPPjC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 11:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbVGPPjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 11:39:02 -0400
Received: from isilmar.linta.de ([213.239.214.66]:33946 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261664AbVGPPiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 11:38:06 -0400
Date: Sat, 16 Jul 2005 17:38:05 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Frederic Gaus <frederic@gaus.name>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCMCIA_SOCKET unable to apply filter after Ram Upgrade
Message-ID: <20050716153805.GA8228@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Frederic Gaus <frederic@gaus.name>, linux-kernel@vger.kernel.org
References: <42D9245C.7070601@gaus.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D9245C.7070601@gaus.name>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jul 16, 2005 at 05:14:36PM +0200, Frederic Gaus wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi folks!
> 
> I've recently done a RAM upgrade on my IBM Thinkpad R40 (2722).
> 
> 1. Ram-Chip: pc2100 cl 2.5 512 MB
> 2. Ram-Chip: pc2700 cl 2.5 1024 MB
> 
> When booting with only one Chip inside, everything works perfecly.
> (Never mind in which slot). But when using both, I get this error
> message every few seconds:
> 
> 	kernel: cs: pcmcia_socket0: unable to apply power.
> 
> Changing the slots does't fix the problem. High Memory Support is enabled.
> 
> Who can help? Or do you need more information?

Probably a BIOS bug which we need to work around. Please send me the output
of dmesg and /proc/iomem with 1GB RAM.

	Dominik
