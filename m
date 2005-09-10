Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbVIJIfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbVIJIfE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 04:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbVIJIfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 04:35:04 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:59275
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1750700AbVIJIfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 04:35:02 -0400
Subject: 2nd Try - [PATCH Linus Git] README.ipw2200 does not contain
	firmware information.
From: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
Reply-To: abonilla@linuxwireless.org
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
       jketreno@linux.intel.com
In-Reply-To: <1126057717.5165.9.camel@localhost.localdomain>
References: <1126057717.5165.9.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 10 Sep 2005 02:35:03 -0600
Message-Id: <1126341303.6041.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I was wondering why this change hasn't made it into the Linus Git so
far.

Thanks.


On Tue, 2005-09-06 at 19:48 -0600, Alejandro Bonilla Beeche wrote:
> Hi,
> 
> 	The kconfig from net/wireless says to look at the README.ipw2200 for
> further installation of the firmware file. We have that information unde
> INSTALL not under README.ipw2200, still I just added a part that talks
> about installing the firmware file. This because README.ipw2200 is
> already in the Documentation/networking/.
> 
> I'm still spamming everyone cause I have not been told where to send
> this directly. :-)
> 
> Signed-off-by: Alejandro Bonilla <abonilla@linuxwireless.org>
> 
> Pasted and attached.
> 
> debian:~/linux-2.6# diff -usr Documentation/networking/README.ipw2200~
> Documentation/networking/README.ipw2200
> 
> --- Documentation/networking/README.ipw2200~    2005-09-06
> 19:33:24.000000000 -0600
> +++ Documentation/networking/README.ipw2200     2005-09-06
> 19:33:24.000000000 -0600
> @@ -27,7 +27,8 @@
>  1.4. Sysfs Helper Files
>  2.   About the Version Numbers
>  3.   Support
> -4.   License
> +4.   Firmware installation
> +5.   License
>  
> 
>  1.   Introduction
> @@ -272,7 +273,18 @@
>      http://ipw2200.sf.net/
>  
> 
> -4.  License
> +4.  Firmware installation
> +----------------------------------------------
> +
> +The driver requires a firmware image, download it and extract the files
> +under /lib/firmware
> +
> +The firmware can be downloaded from the following URL:
> +
> +    http://ipw2200.sf.net/
> +
> +
> +5.  License
>  -----------------------------------------------
>  
>    Copyright(c) 2003 - 2005 Intel Corporation. All rights reserved.
> 

