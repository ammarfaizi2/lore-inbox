Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVEFIEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVEFIEg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 04:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVEFIEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 04:04:35 -0400
Received: from coderock.org ([193.77.147.115]:27869 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261167AbVEFIE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 04:04:26 -0400
Date: Fri, 6 May 2005 10:04:15 +0200
From: Domen Puncer <domen@coderock.org>
To: Benjamin Reed <breed@zuzulu.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic wep keys for airo.c
Message-ID: <20050506080415.GD3917@nd47.coderock.org>
References: <200505030826.42564.breed@zuzulu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505030826.42564.breed@zuzulu.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/05 08:26 -0700, Benjamin Reed wrote:
>  module_param_array(ssids, charp, NULL, 0);
>  module_param(auto_wep, int, 0);
> +module_param(perm_key_support, int, 1);

				       ^ permissions in sysfs

>   if (rc!=SUCCESS) printk(KERN_ERR "airo:  WEP_TEMP set %x\n", rc);
>   if (perm) {
> +  // We make these messages debug. They really should be error,
> +  // but no one seems to use the TEMP flag and writing a PERM key
> +  // with the MAC disable throws this error

/* */?


	Domen
