Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265099AbTARWXO>; Sat, 18 Jan 2003 17:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265134AbTARWXO>; Sat, 18 Jan 2003 17:23:14 -0500
Received: from havoc.daloft.com ([64.213.145.173]:42901 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S265099AbTARWXO>;
	Sat, 18 Jan 2003 17:23:14 -0500
Date: Sat, 18 Jan 2003 17:32:10 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Andrew Grover <andrew.grover@intel.com>
Subject: Re: Code obfuscation in acpi
Message-ID: <20030118223210.GA31860@gtf.org>
References: <20030118213134.GA8968@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030118213134.GA8968@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 18, 2003 at 10:31:34PM +0100, Pavel Machek wrote:
> 
> #define acpi_driver_data(d)     ((d)->driver_data)
> 
> ... very nice for obfuscating code ...

sysfs-based buses use <foo>_{get,set}_drvdata, which looks exactly the
same as this here.

	Jeff


