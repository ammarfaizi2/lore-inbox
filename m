Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWGKPpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWGKPpG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 11:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWGKPpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 11:45:06 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:43959 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751302AbWGKPpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 11:45:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=IjCz1wFqUnjdOn1np7bsrHWcgRYPmsz1//qxPFRCVxe9PpEtMTgQn1v0+odkRYquLSCskPFynZxVFWjJTsQaplip5k28PVT8rAx1Ki/xCn90v+e67YwNOjQiYE5IlF3FlHUx+N3jyMDlKq4ednwX0jsathMGAv+JDbOutDFlqe0=
Message-ID: <44B3C781.8060005@gmail.com>
Date: Tue, 11 Jul 2006 17:45:05 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove mentionings of devfs in documentation
References: <20060711152546.GV13938@stusta.de>
In-Reply-To: <20060711152546.GV13938@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

Adrian Bunk:
> Now that devfs is removed, there's no longer any need to document how to 
> do this or that with devfs.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
[snip]
> --- linux-2.6.18-rc1-mm1-full/Documentation/ABI/obsolete/devfs	2006-07-09 11:22:37.000000000 +0200
> +++ /dev/null	2006-04-23 00:42:46.000000000 +0200
> @@ -1,13 +0,0 @@
> -What:		devfs
> -Date:		July 2005
> -Contact:	Greg Kroah-Hartman <gregkh@suse.de>
> -Description:
> -	devfs has been unmaintained for a number of years, has unfixable
> -	races, contains a naming policy within the kernel that is
> -	against the LSB, and can be replaced by using udev.
> -	The files fs/devfs/*, include/linux/devfs_fs*.h will be removed,
> -	along with the the assorted devfs function calls throughout the
> -	kernel tree.
> -
> -Users:
> -

According to Documentation/ABI/README
"  removed/
        This directory contains a list of the old interfaces that have
        been removed from the kernel.
"

we should add devfs to removed/

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work-clean/Documentation/dontdiff linux-work-clean/Documentation/ABI/removed/devfs linux-work5/Documentation/ABI/removed/devfs
--- linux-work-clean/Documentation/ABI/removed/devfs	1970-01-01 01:00:00.000000000 +0100
+++ linux-work5/Documentation/ABI/removed/devfs	2006-07-11 17:35:30.000000000 +0200
@@ -0,0 +1,13 @@
+What:		devfs
+Date:		July 2005
+Contact:	Greg Kroah-Hartman <gregkh@suse.de>
+Description:
+	devfs has been unmaintained for a number of years, has unfixable
+	races, contains a naming policy within the kernel that is
+	against the LSB, and can be replaced by using udev.
+	The files fs/devfs/*, include/linux/devfs_fs*.h will be removed,
+	along with the the assorted devfs function calls throughout the
+	kernel tree.
+
+Users:
+

