Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030247AbVHPRGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbVHPRGV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 13:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030249AbVHPRGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 13:06:21 -0400
Received: from siaag2ai.mx.compuserve.com ([149.174.40.147]:33449 "EHLO
	siaag2ai.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030247AbVHPRGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 13:06:20 -0400
Date: Tue, 16 Aug 2005 13:03:43 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 7/14] i386 / Add some descriptor convenience
  functions
To: Zachary Amsden <zach@vmware.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200508161306_MC3-1-A75D-6645@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2005 at 21:56:20 -0700, zach@vmware.com wrote:

> Patch-base: 2.6.13-rc5-mm1
> Patch-keys: i386 desc cleanup
> Signed-off-by: Zachary Amsden <zach@vmware.com>
> Index: linux-2.6.13/include/asm-i386/desc.h
> ===================================================================
> --- linux-2.6.13.orig/include/asm-i386/desc.h 2005-08-09 19:43:38.000000000 -0700
> +++ linux-2.6.13/include/asm-i386/desc.h      2005-08-10 20:42:03.000000000 -0700
> @@ -14,6 +14,28 @@
>  
>  #include <asm/mmu.h>
>  
> +#define desc_empty(desc) \
> +             (!((desc)->a + (desc)->b))
> +

     I think that should be "|" instead of "+".

__
Chuck
