Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263044AbVFXUiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263044AbVFXUiU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 16:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVFXUiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 16:38:20 -0400
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:7686 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261630AbVFXUgF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 16:36:05 -0400
Date: Fri, 24 Jun 2005 22:36:04 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/ne3210.c: cleanups
Message-Id: <20050624223604.3aec0cb1.khali@linux-fr.org>
In-Reply-To: <20050624200919.GK6656@stusta.de>
References: <20050624200919.GK6656@stusta.de>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

>  	if (ei_debug > 0)
> -		printk(version);
> +		printk("ne3210 loaded.\n");

No KERN_DEBUG?

Thanks,
-- 
Jean Delvare
