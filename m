Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268105AbTB1Ts5>; Fri, 28 Feb 2003 14:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268111AbTB1Ts5>; Fri, 28 Feb 2003 14:48:57 -0500
Received: from verein.lst.de ([212.34.181.86]:14343 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S268105AbTB1Ts5>;
	Fri, 28 Feb 2003 14:48:57 -0500
Date: Fri, 28 Feb 2003 20:58:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix scsi_probe_and_add_lun
Message-ID: <20030228205859.A26967@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Marc Zyngier <mzyngier@freesurf.fr>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <wrp3cm8gpag.fsf@hina.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <wrp3cm8gpag.fsf@hina.wild-wind.fr.eu.org>; from mzyngier@freesurf.fr on Fri, Feb 28, 2003 at 08:48:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 08:48:07PM +0100, Marc Zyngier wrote:
> Christoph,
> 
> The following patch fixes a bug introduced in the recent scsi_scan.c
> reorganisation.
> 
> Without this patch, my Alpha Jensen was crashing just after detecting
> its first SCSI disk. It is now working fine.

Argg, stupid mistake - thanks for the patch.

