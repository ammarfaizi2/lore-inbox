Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752382AbWJOECV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbWJOECV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 00:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752378AbWJOECV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 00:02:21 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:49318 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1752381AbWJOECU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 00:02:20 -0400
Date: Sat, 14 Oct 2006 21:03:11 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Matt LaPlante <kernel1@cyberdogtech.com>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH 19-rc2]  Fix misc Kconfig typos
Message-Id: <20061014210311.87ef41f6.randy.dunlap@oracle.com>
In-Reply-To: <20061014225447.49c9112a.kernel1@cyberdogtech.com>
References: <20061014225447.49c9112a.kernel1@cyberdogtech.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Oct 2006 22:54:47 -0400 Matt LaPlante wrote:

> Fix various Kconfig typos.
> 
> Signed-off-by: Matt LaPlante <kernel1@cyberdogtech.com>

I have one minor change request (below), otherwise
Acked-by: Randy Dunlap <randy.dunlap@oracle.com>


> diff -ru a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> --- a/drivers/net/phy/Kconfig	2006-09-19 23:42:06.000000000 -0400
> +++ b/drivers/net/phy/Kconfig	2006-10-14 22:16:01.000000000 -0400
> @@ -61,8 +61,8 @@
>  	depends on PHYLIB
>  	---help---
>  	  Adds the driver to PHY layer to cover the boards that do not have any PHY bound,
> -	  but with the ability to manipulate with speed/link in software. The relavant MII
> -	  speed/duplex parameters could be effectively handled in user-specified  fuction.
> +	  but with the ability to manipulate with speed/link in software. The relevant MII

for the second "with":
s/with/the/ or s/with//

> +	  speed/duplex parameters could be effectively handled in a user-specified function.
>  	  Currently tested with mpc866ads.
>  
>  config FIXED_MII_10_FDX


---
~Randy
