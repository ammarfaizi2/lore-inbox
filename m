Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267656AbUJGRcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267656AbUJGRcN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 13:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267396AbUJGRMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 13:12:06 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:7187 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S267497AbUJGQ7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 12:59:23 -0400
Date: Thu, 7 Oct 2004 18:58:49 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Andrew Vasquez <andrew.vasquez@qlogic.com>,
       James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc3-mm3: `risc_code_addr01' multiple definition
Message-ID: <20041007165849.GA4493@stusta.de>
References: <20041007015139.6f5b833b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041007015139.6f5b833b.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 01:51:39AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.9-rc3-mm2:
>...
>  bk-scsi.patch
>...

This causes the following compile error:


<--  snip  -->

...
  LD      drivers/scsi/built-in.o
drivers/scsi/qla1280.o(.data+0xe65c): multiple definition of `risc_code_addr01'
drivers/scsi/qlogicfc.o(.data+0x0): first defined here
make[2]: *** [drivers/scsi/built-in.o] Error 1

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

