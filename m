Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbULVRgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbULVRgJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 12:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbULVRgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 12:36:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45454 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261992AbULVRgG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 12:36:06 -0500
Date: Wed, 22 Dec 2004 11:14:21 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "m.bar???? demiray" <baris@idealteknoloji.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.29-pre2-bk2 won't compile (Redefinition errors)
Message-ID: <20041222131421.GB3088@logos.cnet>
References: <41C8D790.8080300@idealteknoloji.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C8D790.8080300@idealteknoloji.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 04:10:24AM +0200, "m.bar???? demiray" wrote:
> Hi,
> Recent 2.4.29-pre2-bk2 patch moves msecs_to_jiffies() and msleep() from 
> include/linux/libata-compat.h to include/linux/delay.h with several 
> revisions as i see.
> 
> But 2.4.29-pre2-bk2 won't compile on my box because these functions 
> still exist in drivers/block/sx8.c and drivers/net/forcedeth.c files and 
> causing redefinition errors. I think they're forgotten.
> 
> If they're forgotten there, patches that remove them are attachted (i 
> have a clean compilation with them). If not so, please tell me what i am 
> doing wrong (my .config is attached).

No you are right, patch applied, thanks!
