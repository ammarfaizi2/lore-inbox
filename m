Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751504AbWEOUpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbWEOUpO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 16:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWEOUpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 16:45:13 -0400
Received: from xenotime.net ([66.160.160.81]:26557 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751504AbWEOUpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 16:45:11 -0400
Date: Mon, 15 May 2006 13:47:37 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Heiko J Schick <schihei@de.ibm.com>
Cc: openib-general@openib.org, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com, schihei@de.ibm.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 12/16] ehca: firmware InfiniBand interface
Message-Id: <20060515134737.c03e02d3.rdunlap@xenotime.net>
In-Reply-To: <4468BD99.5050505@de.ibm.com>
References: <4468BD99.5050505@de.ibm.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2006 19:42:49 +0200 Heiko J Schick wrote:

> Signed-off-by: Heiko J Schick <schickhj@de.ibm.com>
> 
> 
>   drivers/infiniband/hw/ehca/hcp_if.c | 1476 ++++++++++++++++++++++++++++++++++++
>   drivers/infiniband/hw/ehca/hcp_if.h |  330 ++++++++
>   2 files changed, 1806 insertions(+)
> 
> 
> 
> --- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/hcp_if.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/hcp_if.h	2006-05-12 12:48:21.000000000 +0200
> @@ -0,0 +1,330 @@

> +/**
> + * hipz_h_alloc_resource_eq - Allocate EQ resources in HW and FW, initalize
> + * resources, create the empty EQPT (ring).
> + *
> + * @eq_handle:         eq handle for this queue
> + * @act_nr_of_entries: actual number of queue entries
> + * @act_pages:         actual number of queue pages
> + * @eq_ist:            used by hcp_H_XIRR() call
> + */

kernel-doc format needs:
1.  a short function name + description on one line
2.  no blank line between function and parameters
3.  blank line (optional) before more detailed function description

See Documentation/kernel-doc-nano-HOWTO.txt or other kernel source
files for more info.
And please test it with "make htmldocs" or "make mandocs".

---
~Randy
