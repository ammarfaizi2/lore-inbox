Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbTIWUhj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 16:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbTIWUhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 16:37:39 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:57736 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262168AbTIWUhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 16:37:32 -0400
Date: Tue, 23 Sep 2003 22:37:20 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org
Subject: Re: [PATCH] Memory leak in mtd/chips/cfi_cmdset_0020.c
Message-ID: <20030923203720.GB1599@wohnheim.fh-wedel.de>
References: <3F709E0D.7090307@terra.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3F709E0D.7090307@terra.com.br>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 September 2003 16:25:01 -0300, Felipe W Damasio wrote:
> 
> 	Patch against 2.6-test5.
> 
> 	If other kmallocs failed after successfully allocating a "struct 
> mtd_info", it should be freed before returning NULL.
> 
> 	This function is called by inter_module_register...so I'm not sure 
> 	it should really be freed...please review :)
> 
> 	Don't have the hardware, so just compilation checked.

Very few people do, STMicro sells those chips to a handpicked group of
users only.  And none of them use 2.6 yet, to my knowledge.  But your
patch looks fine, so please do apply, Andrew and David.

Jörn

-- 
A defeated army first battles and then seeks victory.
-- Sun Tzu
