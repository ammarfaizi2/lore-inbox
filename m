Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130289AbRBKUz4>; Sun, 11 Feb 2001 15:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130436AbRBKUzq>; Sun, 11 Feb 2001 15:55:46 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:36102 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130289AbRBKUzf>;
	Sun, 11 Feb 2001 15:55:35 -0500
Message-ID: <3A86FC24.46744862@mandrakesoft.com>
Date: Sun, 11 Feb 2001 15:55:00 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Philip Blundell <philb@gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: small patch for unsigned char breakage in rtl8129 driver
In-Reply-To: <E14S39a-0004wd-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > -     char phys[4];                                           /* MII device addresses. */
> > +     signed char phys[4];                            /* MII device addresses. */
> 
> 8129 is deprecated for the current 8139too driver which is the only stable
> driver for it. Does 8139too (from current -ac) work on ARM ?

I've gotten at least one report that it does

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
