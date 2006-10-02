Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWJBNGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWJBNGY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 09:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWJBNGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 09:06:24 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28554 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932280AbWJBNGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 09:06:24 -0400
Date: Mon, 2 Oct 2006 15:06:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-ide@vger.intel.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       rdunlap@xenotime.net
Subject: Re: [patch 1/2] libata: _GTF support
Message-ID: <20061002130622.GA13617@elf.ucw.cz>
References: <20060928182211.076258000@localhost.localdomain> <20060928112901.62ee8eba.kristen.c.accardi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928112901.62ee8eba.kristen.c.accardi@intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> _GTF is an acpi method that is used to reinitialize the drive.  It returns
> a task file containing ata commands that are sent back to the drive to restore
> it to boot up defaults.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

> @@ -1011,6 +1012,10 @@ and is between 256 and 4096 characters. 
>  			emulation library even if a 387 maths coprocessor
>  			is present.
>  
> +	noacpi		[LIBATA] Disables use of ACPI in libata suspend/resume
> +			when set.
> +			Format: <int>

Ugh, so we have noacpi=0/1, and it only affects suspend/resume? We
definitely need better name here.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
