Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261480AbREQSlT>; Thu, 17 May 2001 14:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261483AbREQSlJ>; Thu, 17 May 2001 14:41:09 -0400
Received: from mail.zmailer.org ([194.252.70.162]:58373 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S261480AbREQSlG>;
	Thu, 17 May 2001 14:41:06 -0400
Date: Thu, 17 May 2001 21:40:39 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "Udo A. Steinberg" <reality@delusion.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.4-ac10
Message-ID: <20010517214039.I5947@mea-ext.zmailer.org>
In-Reply-To: <E150QuA-0005ah-00@the-village.bc.nu> <3B041980.BC22BA38@delusion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B041980.BC22BA38@delusion.de>; from reality@delusion.de on Thu, May 17, 2001 at 08:33:36PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2001 at 08:33:36PM +0200, Udo A. Steinberg wrote:
> With 2.4.4-ac10 and binutils 2.11 I get the following warnings:

  It is a warning about kernel code using assembler statements
  which are not valid with some older assemblers.

> gcc -D__KERNEL__ -I/usr/src/linux-2.4.4-ac/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4     -c -o pci-pc.o pci-pc.c
> pci-pc.c:964: warning: `pci_fixup_via691' defined but not used
> pci-pc.c:977: warning: `pci_fixup_via691_2' defined but not used
> {standard input}: Assembler messages:
> {standard input}:747: Warning: indirect lcall without `*'
> {standard input}:832: Warning: indirect lcall without `*'
> {standard input}:919: Warning: indirect lcall without `*'
> {standard input}:958: Warning: indirect lcall without `*'
> {standard input}:990: Warning: indirect lcall without `*'
> {standard input}:1022: Warning: indirect lcall without `*'
> {standard input}:1053: Warning: indirect lcall without `*'
> {standard input}:1082: Warning: indirect lcall without `*'
> {standard input}:1111: Warning: indirect lcall without `*'
> {standard input}:1392: Warning: indirect lcall without `*'
> {standard input}:1497: Warning: indirect lcall without `*'
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.4-ac/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4     -c -o apm.o apm.c
> {standard input}: Assembler messages:
> {standard input}:180: Warning: indirect lcall without `*'
> {standard input}:274: Warning: indirect lcall without `*'
> 
> 
> Does anyone know what's up with that? Kernel problem or binutils issue?
> 
> Regards,
> Udo.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
