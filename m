Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267785AbUJVUue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267785AbUJVUue (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 16:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267746AbUJVUsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 16:48:46 -0400
Received: from imag.imag.fr ([129.88.30.1]:45798 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S267565AbUJVUdD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 16:33:03 -0400
Date: Fri, 22 Oct 2004 22:32:59 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-mm1
Message-ID: <20041022203259.GA23441@linux.ensimag.fr>
Reply-To: 20041022032039.730eb226.akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
From: Matthieu Castet <mat@ensilinx1.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (imag.imag.fr [129.88.30.1]); Fri, 22 Oct 2004 22:33:00 +0200 (CEST)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> add-acpi-based-floppy-controller-enumeration.patch
>   Add ACPI-based floppy controller enumeration.
> 
> add-acpi-based-floppy-controller-enumeration-fix.patch
>   add-acpi-based-floppy-controller-enumeration fix
> 
> update-acpi-floppy-enumeration.patch
>   update ACPI floppy enumeration
> 
> floppy-acpi-enumeration-update.patch
>   floppy ACPI enumeration update

Why not using ACPI pnp patch [1] and convert this driver to use pnp core.
It will be simpler and compatible with pnpbios...


Matthieu

[1]
http://marc.theaimsgroup.com/?l=linux-kernel&m=109834588507413&w=2
