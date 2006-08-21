Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWHUX2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWHUX2T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 19:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWHUX2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 19:28:19 -0400
Received: from xenotime.net ([66.160.160.81]:23786 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751321AbWHUX2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 19:28:18 -0400
Date: Mon, 21 Aug 2006 16:31:21 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Henne <henne@nachtwindheim.de>, jgarzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [LIBATA] [mm] change path to libata in libata.tmpl
Message-Id: <20060821163121.93d7f0d5.rdunlap@xenotime.net>
In-Reply-To: <44EA3E32.7060607@nachtwindheim.de>
References: <44EA3E32.7060607@nachtwindheim.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2006 01:13:54 +0200 Henne wrote:

> From: Henrik Kretzschmar <henne@nachtwindheim.de>
> 
> Since libata moved from /drivers/scsi to /drivers/ata this template is broken.
> This patch fixes it.
> Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
> ---

Acked-by: Randy Dunlap <rdunlap@xenotime.net>

Thanks.

> --- linux-2.6.18-rc4/Documentation/DocBook/libata.tmpl	2006-08-11 10:08:05.000000000 +0200
> +++ linux-2.6.18-rc4-mm1/Documentation/DocBook/libata.tmpl	2006-08-18 17:13:10.000000000 +0200
> @@ -868,18 +868,18 @@
>  
>    <chapter id="libataExt">
>       <title>libata Library</title>
> -!Edrivers/scsi/libata-core.c
> +!Edrivers/ata/libata-core.c
>    </chapter>
>  
>    <chapter id="libataInt">
>       <title>libata Core Internals</title>
> -!Idrivers/scsi/libata-core.c
> +!Idrivers/ata/libata-core.c
>    </chapter>
>  
>    <chapter id="libataScsiInt">
>       <title>libata SCSI translation/emulation</title>
> -!Edrivers/scsi/libata-scsi.c
> -!Idrivers/scsi/libata-scsi.c
> +!Edrivers/ata/libata-scsi.c
> +!Idrivers/ata/libata-scsi.c
>    </chapter>
>  
>    <chapter id="ataExceptions">
> @@ -1600,12 +1600,12 @@
>  
>    <chapter id="PiixInt">
>       <title>ata_piix Internals</title>
> -!Idrivers/scsi/ata_piix.c
> +!Idrivers/ata/ata_piix.c
>    </chapter>
>  
>    <chapter id="SILInt">
>       <title>sata_sil Internals</title>
> -!Idrivers/scsi/sata_sil.c
> +!Idrivers/ata/sata_sil.c
>    </chapter>
>  
>    <chapter id="libataThanks">
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


---
~Randy
