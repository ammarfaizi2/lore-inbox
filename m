Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbVLCQLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbVLCQLf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 11:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbVLCQLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 11:11:35 -0500
Received: from aveiro.procergs.com.br ([200.198.128.42]:35257 "EHLO
	aveiro.procergs.com.br") by vger.kernel.org with ESMTP
	id S1751278AbVLCQLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 11:11:34 -0500
From: Otavio Salvador <otavio@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/11] OSS: replace all uses of pci_module_init with pci_register_driver
Organization: O.S. Systems Ltda.
References: <11336254302237-git-send-email-otavio@debian.org>
X-URL: http://www.debian.org/~otavio/
X-Attribution: O.S.
Date: Sat, 03 Dec 2005 14:12:28 -0200
In-Reply-To: <11336254302237-git-send-email-otavio@debian.org> (Otavio
	Salvador's message of "Sat, 3 Dec 2005 13:57:10 -0200")
Message-ID: <87r78u2m8j.fsf@nurf.casa>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Otavio Salvador <otavio@debian.org> writes:

> diff --git a/sound/oss/es1371.c b/sound/oss/es1371.c
> index 12a56d5..f770df8 100644
> --- a/sound/oss/es1371.c
> +++ b/sound/oss/es1371.c
> @@ -94,7 +94,7 @@
>   *    07.02.2000   0.24  Use pci_alloc_consistent and pci_register_driver
>   *    07.02.2000   0.25  Use ac97_codec
>   *    01.03.2000   0.26  SPDIF patch by Mikael Bouillot <mikael.bouillot@bigfoot.com>
> - *                       Use pci_module_init
> + *                       Use pci_register_driver
>   *    21.11.2000   0.27  Initialize dma buffers in poll, otherwise poll may return a bogus mask
>   *    12.12.2000   0.28  More dma buffer initializations, patch from
>   *                       Tjeerd Mulder <tjeerd.mulder@fujitsu-siemens.com>
> @@ -3090,7 +3090,7 @@ static struct pci_driver es1371_driver =

This hook shouldn't be applied. Sorry for that.

-- 
        O T A V I O    S A L V A D O R
---------------------------------------------
 E-mail: otavio@debian.org      UIN: 5906116
 GNU/Linux User: 239058     GPG ID: 49A5F855
 Home Page: http://www.freedom.ind.br/otavio
---------------------------------------------
"Microsoft gives you Windows ... Linux gives
 you the whole house."
