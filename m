Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbWEVA5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbWEVA5R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 20:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbWEVA5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 20:57:17 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51655 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964969AbWEVA5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 20:57:16 -0400
Date: Mon, 22 May 2006 02:56:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: jayakumar.acpi@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH/RFC 2.6.17-rc4 1/1] ACPI: Atlas ACPI driver v2
Message-ID: <20060522005634.GB25434@elf.ucw.cz>
References: <200605190153.k4J1rW0U002537@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605190153.k4J1rW0U002537@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hi Len, ACPI, and kernel folk,
> 
> Appended is a refresh of my patch adding an ACPI driver for Atlas
> boards. I've done this patch against 2.6.17-rc4 and the only change
> from the previous version is addition of input support.

> diff -X linux-2.6.17-rc4/Documentation/dontdiff -X excludevid -uprN linux-2.6.17-rc4-vanilla/drivers/acpi/atlas_acpi.c linux-2.6.17-rc4/drivers/acpi/atlas_acpi.c
> --- linux-2.6.17-rc4-vanilla/drivers/acpi/atlas_acpi.c	1970-01-01 07:30:00.000000000 +0730
> +++ linux-2.6.17-rc4/drivers/acpi/atlas_acpi.c	2006-05-19 08:57:09.000000000 +0800
> +
> +#define PROC_ATLAS			"atlas"

And this is now unused... good. (But please remove the define).

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
