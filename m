Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135318AbREEUh6>; Sat, 5 May 2001 16:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135339AbREEUht>; Sat, 5 May 2001 16:37:49 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:495 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S135318AbREEUh3>; Sat, 5 May 2001 16:37:29 -0400
Date: Sat, 5 May 2001 22:37:27 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Frank Klemm <pfk@fuchs.offl.uni-jena.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Next compile time problem ...
Message-ID: <20010505223727.I754@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010505212009.A14529@fuchs.offl.uni-jena.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010505212009.A14529@fuchs.offl.uni-jena.de>; from pfk@fuchs.offl.uni-jena.de on Sat, May 05, 2001 at 09:20:09PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2001 at 09:20:09PM +0200, Frank Klemm wrote:
> 
> Compiling of kernel 2.4.3 stops:

Try compiling a RECENT kernel.

> Messages and .config are appended.

> buz.c:188: `KMALLOC_MAXSIZE' undeclared (first use in this function)

buz.c will die soon. It will be integrated into the zoran driver.
Read the archives for details.

> dscc4.c:1745: `PCI_VENDOR_ID_SIEMENS' undeclared here (not in a function)
> dscc4.c:1745: initializer element is not constant
> dscc4.c:1745: (near initialization for `dscc4_pci_tbl[0].vendor')
> dscc4.c:1745: `PCI_DEVICE_ID_SIEMENS_DSCC4' undeclared here (not in a function)

Fixed in 2.4.4 and later. Try compiling a recent kernel. 

I'm running 2.4.5-pre1 now with SMP and highmem support enabled
and used.

Hope that helps

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
