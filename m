Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129181AbRBKNCi>; Sun, 11 Feb 2001 08:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129182AbRBKNCS>; Sun, 11 Feb 2001 08:02:18 -0500
Received: from smtp-rt-1.wanadoo.fr ([193.252.19.151]:60388 "EHLO
	anagyris.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S129181AbRBKNCJ>; Sun, 11 Feb 2001 08:02:09 -0500
Message-ID: <3A868CFE.858E50FC@wanadoo.fr>
Date: Sun, 11 Feb 2001 14:00:46 +0100
From: Jean-luc Coulon <jean-luc.coulon@wanadoo.fr>
Organization: personal system
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.19pre9 i586)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Power off 2.4.xx and ACPI / APM
In-Reply-To: <3A85A692.E3FE8DAF@wanadoo.fr> <3A85A881.FC161D3C@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

>
> Does this ACPI problem occur with 2.4.2-pre3?  (patch available from
> ftp://ftp.fr.kernel.org/pub/linux/kernel/testing/)
>

Yep! The same problem with all the 2.4.x  and 2.4.x-prey.

My .config is :
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
CONFIG_APM_CPU_IDLE=y
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

------

Regards

        Jean-Luc

>
> --
> Jeff Garzik       | "You see, in this world there's two kinds of
> Building 1024     |  people, my friend: Those with loaded guns
> MandrakeSoft      |  and those who dig. You dig."  --Blondie

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
