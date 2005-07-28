Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbVG1Uiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVG1Uiz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 16:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVG1UgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 16:36:19 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4617 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261664AbVG1UeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 16:34:04 -0400
Date: Thu, 28 Jul 2005 22:34:01 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Tony Luck <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>,
       andrew.vasquez@qlogic.com
Subject: Re: 2.6.13-rc3-mm3
Message-ID: <20050728203401.GB4790@stusta.de>
References: <20050728025840.0596b9cb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050728025840.0596b9cb.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2005 at 02:58:40AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.13-rc3-mm2:
>...
> +qla2xxx-mark-dependency-on-fw_loader.patch
> 
>  qlogic Kconfig fix
>...

This patch is wrong since it adds a select to SCSI_QLA2XXX.
Please drop it.

Andrew Vasquez had a better fix and is discussing it with James.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

