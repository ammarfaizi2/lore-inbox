Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbUKJDet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbUKJDet (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 22:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbUKJDet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 22:34:49 -0500
Received: from ozlabs.org ([203.10.76.45]:20712 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261840AbUKJDeq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 22:34:46 -0500
Subject: Re: [PATCH]a tar filesystem for 2.6.10-rc1-mm3
From: Rusty Russell <rusty@rustcorp.com.au>
To: andyliu <liudeyan@gmail.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <aad1205e04110523176bf66a37@mail.gmail.com>
References: <aad1205e04110523176bf66a37@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 10 Nov 2004 14:01:15 +1100
Message-Id: <1100055675.25963.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-06 at 15:17 +0800, andyliu wrote:
> +int tarfs_debug=0;
> +int allow_v7_format=0;
> +MODULE_PARM(tarfs_debug, "i");
> +MODULE_PARM_DESC(debug, "Tarfs debug output flag");
> +MODULE_PARM(allow_v7_format, "i");
> +MODULE_PARM_DESC(allow_v7_format, "Allow v7 format (no magic check)");

Please use module_param().

Thanks,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

