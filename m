Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129693AbRBNXn1>; Wed, 14 Feb 2001 18:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130263AbRBNXnR>; Wed, 14 Feb 2001 18:43:17 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64530 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129693AbRBNXnB>; Wed, 14 Feb 2001 18:43:01 -0500
Subject: Re: [PATCH] i2c 2.5.5
To: jamagallon@able.es (J . A . Magallon)
Date: Wed, 14 Feb 2001 23:43:36 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux-kernel),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <20010215003802.A21100@werewolf.able.es> from "J . A . Magallon" at Feb 15, 2001 12:38:02 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14TBaF-0006TC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -71,4 +71,7 @@
>    }
>  
> +IMPORTANT: because of the use of inline functions, you *have* to use
> +'-O' or some variation when you compile your program!
> +

Considered too obvious to restate

>  
> -This sends a single byte to the device, at the place of the Rd/Wr bit.
> +This sends a single bit to the device, at the place of the Rd/Wr bit.
>  There is no equivalent Read Quick command.

Ok valid


The rest are revision noise and incorrect reverts of include changes

>  #ifndef MODULE
> +#ifdef CONFIG_I2C_CHARDEV
>  	extern int i2c_dev_init(void);

Also reverting a cleanup

