Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262490AbVFUV21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbVFUV21 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 17:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbVFUV0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 17:26:00 -0400
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:18446 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262502AbVFUVXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 17:23:42 -0400
Date: Tue, 21 Jun 2005 23:24:09 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] cleanup patches for strings
Message-Id: <20050621232409.06a3400e.khali@linux-fr.org>
In-Reply-To: <200506211359.25632.vda@ilport.com.ua>
References: <Pine.LNX.4.62.0506200052320.2415@dragon.hyggekrogen.localhost>
	<200506211359.25632.vda@ilport.com.ua>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis,

> I have 361813 bytes in 292 patches for:
> 
> -       printk(KERN_ERR "%s: start receive command failed \n", dev->name);
> +       printk(KERN_ERR "%s: start receive command failed\n", dev->name);
> 
> type patches. Are these needed?

I think so. I can't think of a more useless way to waste memory ;)

> In case you wonder whether YOUR driver has such things, the list:

Could you send me a patch grouping all patches affecting drivers under
drivers/i2c (and possibly include/linux/i2c* files)? I'll get them
merged.

Thanks,
-- 
Jean Delvare
