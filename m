Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265087AbUHFMty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265087AbUHFMty (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 08:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265489AbUHFMty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 08:49:54 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:37033 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265087AbUHFMtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 08:49:51 -0400
Date: Fri, 6 Aug 2004 14:49:41 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: qeth performance.
Message-ID: <20040806124941.GA2065@wohnheim.fh-wedel.de>
References: <20040805131440.GF8251@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040805131440.GF8251@mschwid3.boeblingen.de.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 August 2004 15:14:40 +0200, Martin Schwidefsky wrote:
> 
> qeth network driver performance improvements. The ping time on the
> HiperSockets interface drops from 250 usecs to 50 usecs and the 1 bytes
> request/response test improves from 70000 to 110000 transactions.

Looks good.

> +config QDIO_DEBUG
> +	bool "Extended debugging information"
> +	depends on QDIO
> +	help
> +	  Say Y here to get extended debugging output in /proc/s390dbf/qdio...
> +	  Warning: this option reduces the performance of the QDIO module.
> +
> +	  If unsure, say N.
> +
>  comment "Misc"

> +#ifdef CONFIG_QDIO_DEBUG

> +#ifdef CONFIG_QDIO_DEBUG

> +#ifdef CONFIG_QDIO_DEBUG

> +#ifdef CONFIG_QDIO_DEBUG

> +#ifdef CONFIG_QDIO_DEBUG

> +#ifdef CONFIG_QDIO_DEBUG

> +#ifdef CONFIG_QDIO_DEBUG

> +#ifdef CONFIG_QDIO_DEBUG

> +#ifdef CONFIG_QDIO_DEBUG

> +#ifdef CONFIG_QDIO_DEBUG

> +#ifdef CONFIG_QDIO_DEBUG

> +#ifdef CONFIG_QDIO_DEBUG

> +#ifdef CONFIG_QDIO_DEBUG

> +#ifdef CONFIG_QDIO_DEBUG

> +#ifdef CONFIG_QDIO_DEBUG

After 50% of the patch I grew tired of it.  Martin, since when do you
like excessive use of #ifdef?

Jörn

-- 
And spam is a useful source of entropy for /dev/random too!
-- Jasmine Strong
