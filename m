Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbUKBMss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbUKBMss (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 07:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbUKBMsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 07:48:22 -0500
Received: from imag.imag.fr ([129.88.30.1]:42925 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S261588AbUKBMr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 07:47:59 -0500
Date: Tue, 2 Nov 2004 13:47:48 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.10-rc1-mm2] keyboard / synaptics not working
Message-ID: <20041102124747.GA21851@linux.ensimag.fr>
Reply-To: 1099377976.13831.195.camel@d845pe
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
From: Matthieu Castet <mat@ensilinx1.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (imag.imag.fr [129.88.30.1]); Tue, 02 Nov 2004 13:47:51 +0100 (CET)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I tried that, but w/o bk-acpi.patch, the kernel won't compile, sorry.
> > I don't have the skills to work around that. I've attached the error
> > message from "make bzImage".
> 
> 
> With the unmodified -mm2 tree, please build with CONFIG_PNPACPI=n
> and give that a go.
> 
Yes the 8042 acpi driver need to be converted to a pnp driver.

Same apply for the floppy driver and other acpi driver that use standard
pnp devices.

For the hpet driver I don't know if we should convert it or add it to
the blacklist

> thanks,
> -Len
> 

Matthieu
