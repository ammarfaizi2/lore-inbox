Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263297AbTIWGCG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 02:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263304AbTIWGCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 02:02:06 -0400
Received: from amalthea.dnx.de ([193.108.181.146]:18661 "EHLO amalthea.dnx.de")
	by vger.kernel.org with ESMTP id S263297AbTIWGCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 02:02:04 -0400
Date: Tue, 23 Sep 2003 08:01:58 +0200
From: Robert Schwebel <robert@schwebel.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add 'make uImage' for PPC32
Message-ID: <20030923060158.GJ8367@pengutronix.de>
References: <20030922182928.GM7443@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030922182928.GM7443@ip68-0-152-218.tc.ph.cox.net>
User-Agent: Mutt/1.4i
X-Spam-Score: -5.0 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1A1gFB-0004ou-00*q8.lXA1S.dU*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 11:29:28AM -0700, Tom Rini wrote:
> Hello. The following BK patch adds support for a 'uImage' target on
> PPC32. This will create an image for the U-Boot (and formerly PPCBoot)
> firmware. The patch adds a scripts/mkuboot.sh as a wrapper for the
> U-Boot mkimage program. We put mkuboot.sh into scripts/ because
> U-Boot works on a number of other platforms, and it's likely that they
> will add a uImage target at some point.  Please apply.

Integrating the U-Boot mkimage into the kernel would be a great thing
for us Embedded folks (U-Boot supports most interesting platforms these
days), but I don't like your way to provide a script wrapper around the
"real" mkimage; I'm not sure what the maintainers think about this but I
would prefer a "native" mkuimage.c -> mkuimage.  

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hornemannstraﬂe 12,  31137 Hildesheim, Germany
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4
