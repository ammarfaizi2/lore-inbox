Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265436AbTFSE4K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 00:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265444AbTFSE4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 00:56:10 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:1809 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265436AbTFSE4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 00:56:08 -0400
Date: Thu, 19 Jun 2003 06:10:02 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel@vger.kernel.org, <trivial@rustcorp.com.au>
Subject: Re: [2.5 patch] fix for drivers/video/sis/init301.c
In-Reply-To: <20030617232726.GI29247@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0306190609510.30417-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Already fixed in the newer driver.


On Wed, 18 Jun 2003, Adrian Bunk wrote:

> Hi James,
> 
> the following patch fixes some nonsense in drivers/video/sis/init301.c . 
> I've tested the compilation with 2.5.72.
> 
> --- linux-2.5.72/drivers/video/sis/init301.c.old	2003-06-18 01:22:27.000000000 +0200
> +++ linux-2.5.72/drivers/video/sis/init301.c	2003-06-18 01:23:23.000000000 +0200
> @@ -5282,7 +5282,7 @@
>  #ifdef SIS315H	/* 310/325 series */
>  
>  	if(SiS_Pr->SiS_IF_DEF_CH70xx != 0) {
> -		temp =  temp = SiS_GetCH701x(SiS_Pr,0x61);
> +		temp = SiS_GetCH701x(SiS_Pr,0x61);
>  		if(temp < 1) {
>  		   SiS_SetCH701x(SiS_Pr,0xac76);
>  		   SiS_SetCH701x(SiS_Pr,0x0066);
> 
> 
> 
> Please apply
> Adrian
> 
> 

