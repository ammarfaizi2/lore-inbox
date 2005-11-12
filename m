Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbVKLPDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbVKLPDR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 10:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbVKLPDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 10:03:17 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:19383 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932259AbVKLPDQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 10:03:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ErUJskvXaDVHGDIHOhOlpS3jOvMUect2sQPk4qljfsdVCUnVqKAL44zHi1DuWAbfhlRJ5YKuQwPx7cuCNr26LxcU5hnP6FX/SPM7druEqz0yp2t+VpcglaM9+1VPofOHIu4DbyAFVanV9qIePpmk0q/ffqLmFszeT0XezyZA/A8=
Message-ID: <625fc13d0511120703s3d84f5e1h57862b50847bf7e1@mail.gmail.com>
Date: Sat, 12 Nov 2005 09:03:15 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Sean Young <sean@mess.org>
Subject: Re: 2.6.15-rc1 [PATCH] MTD_TS5500 Kconfig
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051112141929.GA25124@atlantis.8hz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051112141929.GA25124@atlantis.8hz.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/05, Sean Young <sean@mess.org> wrote:
> CONFIG_ELAN does not exist any more.
>
> Signed-off-by: Sean Young <sean@mess.org>
> ---
> diff -uprN a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
> --- a/drivers/mtd/maps/Kconfig  2005-11-12 13:52:48.000000000 +0100
> +++ b/drivers/mtd/maps/Kconfig  2005-11-12 13:52:02.000000000 +0100
> @@ -94,7 +94,7 @@ config MTD_NETSC520
>
>  config MTD_TS5500
>         tristate "JEDEC Flash device mapped on Technologic Systems TS-5500"
> -       depends on ELAN
> +       depends on X86
>         select MTD_PARTITIONS
>         select MTD_JEDECPROBE
>         select MTD_CFI_AMDSTD
> -

Could you send this to the MTD mailing list?

josh
