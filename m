Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965115AbWD0MkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965115AbWD0MkG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 08:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbWD0MkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 08:40:06 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:53483 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S965115AbWD0MkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 08:40:02 -0400
Date: Thu, 27 Apr 2006 14:39:49 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Heiko J Schick <schihei@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
       linuxppc-dev@ozlabs.org, Marcus Eder <MEDER@de.ibm.com>,
       Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, schickhj@de.ibm.com
Subject: Re: [PATCH 01/16] ehca: integration in Linux kernel	build system
Message-ID: <20060427123949.GH32127@wohnheim.fh-wedel.de>
References: <4450B384.4020601@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4450B384.4020601@de.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 April 2006 14:05:24 +0200, Heiko J Schick wrote:
> +
> +hcad_mod-objs = ehca_main.o   \
> +		ehca_hca.o    \
> +		ehca_mcast.o  \
> +		ehca_pd.o     \
> +		ehca_av.o     \
> +		ehca_eq.o     \
> +		ehca_cq.o     \
> +		ehca_qp.o     \
> +		ehca_sqp.o    \
> +		ehca_mrmw.o   \
> +		ehca_reqs.o   \
> +		ehca_irq.o    \
> +		ehca_uverbs.o \
> +		hcp_if.o      \
> +		hcp_phyp.o    \
> +		ipz_pt_fn.o

If you don't consolidate this into 2-3 lines, Sam might turn you into
a toad.

Jörn

-- 
Audacity augments courage; hesitation, fear.
-- Publilius Syrus 
