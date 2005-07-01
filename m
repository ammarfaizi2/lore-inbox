Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbVGBEAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbVGBEAj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 00:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbVGBEAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 00:00:39 -0400
Received: from ozlabs.org ([203.10.76.45]:29611 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261762AbVGBEAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 00:00:35 -0400
Date: Sat, 2 Jul 2005 09:47:19 +1000
From: Anton Blanchard <anton@samba.org>
To: Linda Xie <lxiep@us.ibm.com>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Dave C Boutcher <sleddog@us.ibm.com>,
       Santiago Leon <santil@us.ibm.com>
Subject: Re: [PATCH] IBM VSCSI Client: sending client info to  server
Message-ID: <20050701234719.GA5384@krispykreme>
References: <42C0774C.4050006@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C0774C.4050006@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
 
> The attached patch fixes the problem in IBM VSCSI Client where the 
> client doesn't send the information which is expected by the server.

...

> +	printk(KERN_INFO "rpa_vscsi: SPR_VERSION: %s\n", SRP_VERSION);

Just a small thing, should the printk say SRP_VERSION?

Anton
