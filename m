Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266395AbTGEQ2j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 12:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266396AbTGEQ2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 12:28:39 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:36563 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S266395AbTGEQ2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 12:28:38 -0400
Date: Sat, 5 Jul 2003 13:40:44 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: Fix DMI missing string in -bk2 snapshot
In-Reply-To: <200307051609.h65G9Y88032402@hraefn.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.55L.0307051340250.13355@freak.distro.conectiva>
References: <200307051609.h65G9Y88032402@hraefn.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just did that by hand 5 minutes ago. :)

On Sat, 5 Jul 2003, Alan Cox wrote:

>
> (Now Jeff has snapshots I can fix these things - thanks Jeff)
>
>
> --- ../linux.22-pre2-ac1/include/asm-i386/system.h	2003-07-01 21:18:35.000000000 +0100
> +++ include/asm-i386/system.h	2003-07-05 17:03:32.000000000 +0100
> @@ -375,5 +373,6 @@
>
>  #define BROKEN_ACPI_Sx		0x0001
>  #define BROKEN_INIT_AFTER_S1	0x0002
> +#define BROKEN_PNP_BIOS		0x0004
>
>  #endif
>
