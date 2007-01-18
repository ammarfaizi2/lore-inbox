Return-Path: <linux-kernel-owner+w=401wt.eu-S1752029AbXARP7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbXARP7j (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 10:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752043AbXARP7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 10:59:39 -0500
Received: from an-out-0708.google.com ([209.85.132.244]:43196 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbXARP7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 10:59:38 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cwnlX2eyFluyXEv42g657qn7tyVz3Uyok5kxiLdpYCi/s169kA3sK93GvtDSXE/N5/ke6VKRe/N+K7BpKgPNUqZ1k8PkCCoRQOlMsPEtiGK2QF0uPzwkD2jU9Wt/eivvqisYc3J/VGlOwY35WrXQqmQoboXx2M8mnWQvgV6GWgY=
Message-ID: <8bf247760701180759v6df2ff8y9a523bd65aa1b4e@mail.gmail.com>
Date: Thu, 18 Jan 2007 21:29:33 +0530
From: Ram <vshrirama@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Linux kernel - TI 2430 does not boot in nand
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   Im using Linux 2.6.14-omap-2430ONLY linux which i downloaded for
linux.omap.com
   (This kernel is a TI specific kernel maintained internally by TI)

   Im using a TI 2430 SDP board.

  This kernel, im able to boot in NOR flash, but not in NAND flash.
   However, im able to boot 2.6.19 in NOR and NAND without any problem.
   So, i presume, there is no problem with u-boot bootloader.

   I dont understand why the same kernel with the same bootargs boots
in NOR, but not in NAND.

   All i get is --

OMAP243X SDP # bootm
## Booting image at 80000000 ...
   Image Name:   Linux Kernel Image
   Image Type:   ARM Linux Kernel Image (gzip compressed)
   Data Size:    1404634 Bytes =  1.3 MB
   Load Address: 80c08000
   Entry Point:  80c08000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

Starting kernel ...

Uncompressing Linux..............................................................................................
done, booting the kernel.


I dont know how to debug - since, immediately after i get 'booting the
kernel' it hangs.
how does one debug?

Do i need to check any specific configuration option?.

Should i need to enable a few options in make menuconfig for nand booting?

Any advices,

Regards,
sriram
