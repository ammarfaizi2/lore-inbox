Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262908AbVG2VdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262908AbVG2VdP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 17:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262900AbVG2V2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 17:28:06 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:23364 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262874AbVG2VZX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 17:25:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tLYZPo75udUA23O2plOR8VbsNVm1lRBqkfumw3mmxndtLXAR17CAeUxIDTjGXCHiNxQS5Ac9opsmUA7jp6L1NHUpGmCf6zVAqDYGMH4PlGFOFqR5D0QhpWmeHStfm8/ZMGyV/lT+I6nX8p2VHFJshQFbBba9oKrdvw8y8s463+E=
Message-ID: <cb755df905072914244ebbe55b@mail.gmail.com>
Date: Fri, 29 Jul 2005 21:24:18 +0000
From: Erior <lars.vahlenberg@gmail.com>
To: romieu@fr.zoreil.com
Subject: Re: sis190 driver
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <095433EB6AB9634BB9524203BF7E303C99AA06@EXGBGMB02.europe.cellnetwork.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <095433EB6AB9634BB9524203BF7E303C99AA06@EXGBGMB02.europe.cellnetwork.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Added PHY identifier for the Asus K8S-MX motherboard.

--- sis190.old  2005-07-29 23:16:07.000000000 +0000
+++ sis190.c    2005-07-29 23:15:37.000000000 +0000
@@ -325,6 +325,7 @@ static struct mii_chip_info {
        { "Broadcom PHY BCM5461", { 0x0020, 0x60c0 }, LAN },
        { "Agere PHY ET1101B",    { 0x0282, 0xf010 }, LAN },
        { "Marvell PHY 88E1111",  { 0x0141, 0x0cc0 }, LAN },
+       { "Realtek PHY RTL8201CL",{ 0x0000, 0x8200 }, LAN },
        { NULL, }
 };

/Lars

On 7/29/05, Lars Vahlenberg <lars.vahlenberg@mandator.com> wrote:
> 
> 
> 
> -----Original Message-----
> From: Francois Romieu [mailto:romieu@fr.zoreil.com]
> Sent: Fri 2005-07-29 00:11
> To: linux-kernel@vger.kernel.org
> Cc: pascal.chapperon@wanadoo.fr; Lars Vahlenberg; Alexey Dobriyan;
> jgarzik@pobox.com
> Subject: [patch 2.6.13-rc3] sis190 driver
>  
> Single file patch:
> http://www.zoreil.com/~romieu/sis190/20050728-2.6.13-rc3-sis190-test.patch
> 
> Patch-kit:
> http://www.zoreil.com/~romieu/sis190/20050728-2.6.13-rc3/patches
> 
> Tarball:
> http://www.zoreil.com/~romieu/sis190/20050728-2.6.13-rc3.tar.bz2
> 
> Changes from previous version (20050722)
> o Add endian annotations (Alexey Dobriyan).
> 
> o Hopefully fixed the build of the patch.
> 
> o Minor round of mii/phy related changes. May crash.
> 
> Testing reports/review/patches are always appreciated.
> 
> Ok, now back to washing.
> 
> --
> Ueimor
> 
> 
> 
> 


-- 
There is nothing that cannot be solved through sufficient application
of brute force and ignorance.
