Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWCNWNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWCNWNr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 17:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWCNWNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 17:13:47 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17076 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932525AbWCNWNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 17:13:45 -0500
Date: Tue, 14 Mar 2006 23:13:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Chris Leech <christopher.leech@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/8] [I/OAT] DMA memcpy subsystem
Message-ID: <20060314221336.GB2269@elf.ucw.cz>
References: <20060311022759.3950.58788.stgit@gitlost.site> <20060311022919.3950.43835.stgit@gitlost.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060311022919.3950.43835.stgit@gitlost.site>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> --- /dev/null
> +++ b/drivers/dma/dmaengine.c
> @@ -0,0 +1,360 @@
> +/*****************************************************************************
> +Copyright(c) 2004 - 2006 Intel Corporation. All rights reserved.
> +
> +This program is free software; you can redistribute it and/or modify it
> +under the terms of the GNU General Public License as published by the Free
> +Software Foundation; either version 2 of the License, or (at your option)
> +any later version.
> +
> +This program is distributed in the hope that it will be useful, but WITHOUT
> +ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> +FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> +more details.
> +
> +You should have received a copy of the GNU General Public License along with
> +this program; if not, write to the Free Software Foundation, Inc., 59
> +Temple Place - Suite 330, Boston, MA  02111-1307, USA.
> +
> +The full GNU General Public License is included in this distribution in the
> +file called LICENSE.
> +*****************************************************************************/


Could you use 
/*
 *
 */

comment style, and describe in one or two lines what the source does
in the header?

								Pavel
-- 
209:using System.IO;
