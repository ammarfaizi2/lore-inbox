Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVCGKbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVCGKbs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 05:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbVCGKbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 05:31:47 -0500
Received: from mail.suse.de ([195.135.220.2]:30371 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261741AbVCGKan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 05:30:43 -0500
Date: Mon, 7 Mar 2005 11:30:41 +0100
From: Karsten Keil <kkeil@suse.de>
To: domen@coderock.org
Cc: akpm@osdl.org, c.lucas@ifrance.com, isdn4linux@listserv.isdn4linux.de,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 5/8] drivers/isdn/tpam/*: convert to pci_register_driver
Message-ID: <20050307103041.GA11673@pingi3.kke.suse.de>
Mail-Followup-To: domen@coderock.org, akpm@osdl.org,
	c.lucas@ifrance.com, isdn4linux@listserv.isdn4linux.de,
	linux-kernel@vger.kernel.org
References: <20050306223813.129381ED3D@trashy.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050306223813.129381ED3D@trashy.coderock.org>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.8-24.10-default i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2005 at 11:38:12PM +0100, domen@coderock.org wrote:
> 
> convert from pci_module_init to pci_register_driver
> 
> Signed-off-by: Christophe Lucas <c.lucas@ifrance.com>
> Signed-off-by: Domen Puncer <domen@coderock.org>
> ---
> 
> 
>  kj-domen/drivers/isdn/tpam/tpam_main.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/isdn/tpam/tpam_main.c~pci_register_driver-drivers_isdn_tpam drivers/isdn/tpam/tpam_main.c
> --- kj/drivers/isdn/tpam/tpam_main.c~pci_register_driver-drivers_isdn_tpam	2005-03-05 16:12:25.000000000 +0100
> +++ kj-domen/drivers/isdn/tpam/tpam_main.c	2005-03-05 16:12:25.000000000 +0100
> @@ -278,7 +278,7 @@ static struct pci_driver tpam_driver = {
>  static int __init tpam_init(void) {
>  	int ret;
>  	
> -	ret = pci_module_init(&tpam_driver);
> +	ret = pci_register_driver(&tpam_driver);
>  	if (ret)
>  		return ret;
>  	printk(KERN_INFO "TurboPAM: %d card%s found, driver loaded.\n", 


Note:

All changes to code drivers/isdn/tpam are obsolate, since the code is
obsolate and I already sent a complete remove patch.

-- 
Karsten Keil
SuSE Labs
ISDN development
