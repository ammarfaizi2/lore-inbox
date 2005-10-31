Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbVJaVpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbVJaVpU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 16:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbVJaVpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 16:45:20 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:31369 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932544AbVJaVpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 16:45:19 -0500
Date: Mon, 31 Oct 2005 13:45:14 -0800
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       slpratt@us.ibm.com
Subject: Re: [PATCH 00/13] Adaptive read-ahead V5
Message-ID: <20051031214514.GA4967@RAM>
References: <20051029060216.159380000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051029060216.159380000@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
From: linuxram@us.ibm.com (Ram Pai)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu,

I will run some standard benchmarks and post the results soon.
The benchmarks I have are (1) DSS (TPCH)  (2) iozone (3) sysbench  (4)
tiobench

It will take atleast a week, since some disks on my machine have to be
replaced and the setup has to be remade.

RP

On Sat, Oct 29, 2005 at 02:02:16PM +0800, Wu Fengguang wrote:
> This version of adaptive read-ahead patch features various clean ups.
> Changes include:
> 	- rewrote context based method to make it clean and robust
> 	- improved accuracy of stateful thrashing threshold estimation
> 	- nr_page_aging made right
> 	- sorted out the thrashing protection logic
> 	- enhanced debug/accounting facilities
> 
> Regards,
> Wu Fengguang
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
