Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280357AbRKGKab>; Wed, 7 Nov 2001 05:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280419AbRKGKaW>; Wed, 7 Nov 2001 05:30:22 -0500
Received: from t2.redhat.com ([199.183.24.243]:64765 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S280357AbRKGKaF>; Wed, 7 Nov 2001 05:30:05 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E161Pyh-0003hb-00@the-village.bc.nu> 
In-Reply-To: <E161Pyh-0003hb-00@the-village.bc.nu> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux@hazard.jcu.cz (Jan Marek),
        linux-kernel@vger.kernel.org (linux-kernel)
Subject: Re: Cannot unlock spinlock... Was: Problem in yenta.c, 2nd edition 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 07 Nov 2001 10:29:59 +0000
Message-ID: <14838.1005128999@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
>  Can you disable the winmodem in the BIOS at all. I've seen similar
> reports of audio hangs where the IRQ was shared by a lucent winmodem -
> no idea why since it ought to be passive and minding its own business.

We know enough about that hardware to turn the IRQ off from Linux, don't we?
If it's a common problem, we could make a PCI quirk for it.

--
dwmw2


