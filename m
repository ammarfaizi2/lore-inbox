Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVAMOr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVAMOr5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 09:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbVAMOr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 09:47:57 -0500
Received: from de01egw02.freescale.net ([192.88.165.103]:52175 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261636AbVAMOrj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 09:47:39 -0500
In-Reply-To: <16870.34895.217241.479250@alkaid.it.uu.se>
References: <16870.34895.217241.479250@alkaid.it.uu.se>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <0BED3DCF-6572-11D9-821C-000393DBC2E8@freescale.com>
Content-Transfer-Encoding: 8BIT
Cc: <afleming@freescale.com>, <linux-kernel@vger.kernel.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: 2.6.11-rc1 compile failure on ppc32
Date: Thu, 13 Jan 2005 08:47:28 -0600
To: "Mikael Pettersson" <mikpe@user.it.uu.se>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should be fixed, or I assume the following fixes it (post  
2.6.11-rc1):

http://linux.bkbits.net:8080/linux-2.5/cset@1.2360.1.154? 
nav=index.html|ChangeSet@-1d

- kumar

On Jan 13, 2005, at 8:40 AM, Mikael Pettersson wrote:

> When the kernel is configured for a PMAC (via MULTIPLATFORM),
> then arch/ppc/kernel/perfmon.c fails to compile because the
>  MMCR0_PMXE macro is undefined.
>
> Adding a "#define MMCR0_PMXE 0x04000000" somewhere visible
>  fixes this.
>
> /Mikael
>  -
>  To unsubscribe from this list: send the line "unsubscribe  
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  Please read the FAQ at  http://www.tux.org/lkml/

