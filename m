Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbUKTGAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbUKTGAN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 01:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbUKTGAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 01:00:13 -0500
Received: from siaag2ab.compuserve.com ([149.174.40.132]:49295 "EHLO
	siaag2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S261432AbUKTGAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 01:00:06 -0500
Date: Sat, 20 Nov 2004 00:56:53 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Linux 2.6.9-ac11
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200411200059_MC3-1-8F14-D1B2@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> 2.6.9-ac10
> o     Error path locking fix for appletalk            (Andries Brouwer)
> o     Further binfmt_elf work                         (Jakub Jelinek)
> o     Fix oops in visor driver caused by DoS fixes    (Roger Luethi)
> 
> 2.6.9-ac9
> o     Error out on early exec before rootfs           (Chris Wright)
> 
> 2.6.9-ac7
> o     Apple Ipod-mini size reporting fix              (Avi Kivity)

  These are all merged in 2.6.10-rc now.


> *     Disable PnP BIOS when using ACPI                (Adam Belay)

  This one causes a compile error in -ac only:

drivers/pnp/pnpbios/core.c:541: error: `acpi_disabled
undeclared (first use in this function)


> *     Backport netlink updates/fixes from 10rc2       (Herbert Xu,
>                                                        Dave Miller)

  Ouch.  Is all that really necessary?

 
> o     On some platforms the flashing keylights        (Alan Cox)
>       riggers bogus keyboard warnings. The error
>       appears from other stuff too like keyboard
>       switches so kill it

  Now I'm glad I removed it long ago. :)


  The md linear fix by Neil Brown I sent you a day or so ago is
now merged in 2.6.10.


--Chuck Ebbert  20-Nov-04  00:55:27
