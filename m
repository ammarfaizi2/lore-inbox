Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965231AbWEOVMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965231AbWEOVMB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965232AbWEOVMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:12:01 -0400
Received: from xenotime.net ([66.160.160.81]:32721 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965231AbWEOVMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:12:00 -0400
Date: Mon, 15 May 2006 14:14:28 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Heiko J Schick <schihei@de.ibm.com>
Cc: openib-general@openib.org, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com, schihei@de.ibm.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 01/16] ehca: module infrastructure
Message-Id: <20060515141428.03800e3e.rdunlap@xenotime.net>
In-Reply-To: <4468BD39.3010008@de.ibm.com>
References: <4468BD39.3010008@de.ibm.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2006 19:41:13 +0200 Heiko J Schick wrote:

> Signed-off-by: Heiko J Schick <schickhj@de.ibm.com>
> 
> 
>   drivers/infiniband/hw/ehca/ehca_main.c |  966 +++++++++++++++++++++++++++++++++
>   1 file changed, 966 insertions(+)
> 
> 
> 
> --- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/ehca_main.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/ehca_main.c	2006-05-15 19:17:26.000000000 +0200

> @@ -0,0 +1,966 @@

> +int ehca_open_aqp1     = 0;
> +int ehca_debug_level   = -1;
> +int ehca_hw_level      = 0;
> +int ehca_nr_ports      = 2;
> +int ehca_use_hp_mr     = 0;
> +int ehca_port_act_time = 30;
> +int ehca_poll_all_eqs  = 1;
> +int ehca_static_rate   = -1;

Don't need to init globals to 0.

---
~Randy
