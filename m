Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261519AbREQTfA>; Thu, 17 May 2001 15:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbREQTeu>; Thu, 17 May 2001 15:34:50 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:52484 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261519AbREQTee>; Thu, 17 May 2001 15:34:34 -0400
Subject: Re: Linux 2.4.4-ac10
To: jamagallon@able.es (J . A . Magallon)
Date: Thu, 17 May 2001 20:26:05 +0100 (BST)
Cc: ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser),
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010517210023.A1052@werewolf.able.es> from "J . A . Magallon" at May 17, 2001 09:00:23 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150TPR-0005yN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And a pair more:

No
> --- linux-2.4.4-ac10/include/linux/raid/md_k.h.orig	Thu May 17 19:35:41
> 2001
> +++ linux-2.4.4-ac10/include/linux/raid/md_k.h	Thu May 17 19:36:15 2001
> @@ -38,6 +38,8 @@
>  		case RAID5:		return 5;
>  	}
>  	panic("pers_to_level()");
> +
> +	return 0;

panic appears properly declared as __attribute(noreturn). This looks to me like
a gcc bug
