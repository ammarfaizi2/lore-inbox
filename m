Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316797AbSE3SP6>; Thu, 30 May 2002 14:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316798AbSE3SP5>; Thu, 30 May 2002 14:15:57 -0400
Received: from ns.crrstv.net ([209.128.25.4]:21147 "EHLO mail.crrstv.net")
	by vger.kernel.org with ESMTP id <S316797AbSE3SPz>;
	Thu, 30 May 2002 14:15:55 -0400
Date: Thu, 30 May 2002 15:16:28 -0300
From: "skidley" <skidley@crrstv.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre9-ac2
Message-ID: <20020530181628.GA8190@crrstv.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get following errors in 2.4.19-pre9-ac2, please let me know if any 
other info is needed,

agpgart_be.c: In function `agp_generic_agp_enable':
agpgart_be.c:400: warning: unused variable `cap_id'
agpgart_be.c: In function `intel_815_configure':
agpgart_be.c:1518: warning: passing arg 3 of `pci_write_config_dword'
makes integer from pointer without a cast
agpgart_be.c:1524: `INTEL_I815_APCONT' undeclared (first use in this
function)
agpgart_be.c:1524: (Each undeclared identifier is reported only once
agpgart_be.c:1524: for each function it appears in.)
agpgart_be.c: In function `agp_find_supported_device':
agpgart_be.c:4280: warning: unused variable `scratch'
agpgart_be.c:4280: warning: unused variable `cap_id'
make[4]: *** [agpgart_be.o] Error 1
make[4]: Leaving directory `/home/kernel/linux/drivers/char/agp'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory `/home/kernel/linux/drivers/char/agp'
make[2]: *** [_subdir_agp] Error 2
make[2]: Leaving directory `/home/kernel/linux/drivers/char'
make[1]: *** [_subdir_char] Error 2
make[1]: Leaving directory `/home/kernel/linux/drivers'
make: *** [_dir_drivers] Error 2
-- 
*********************************
* Chad Young                    *
* Registered Linux User #195191 *
*********************************
