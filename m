Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271186AbRHTKfF>; Mon, 20 Aug 2001 06:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271192AbRHTKe4>; Mon, 20 Aug 2001 06:34:56 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30470 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271186AbRHTKeo>; Mon, 20 Aug 2001 06:34:44 -0400
Subject: Re: aic7xxx errors with 2.4.8-ac7 on 440gx mobo
To: cliff@oisec.net (Cliff Albert)
Date: Mon, 20 Aug 2001 11:37:33 +0100 (BST)
Cc: yusufg@outblaze.com (Yusuf Goolamabbas), linux-kernel@vger.kernel.org,
        gibbs@scsiguy.com
In-Reply-To: <20010820105520.A22087@oisec.net> from "Cliff Albert" at Aug 20, 2001 10:55:20 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15YmR3-0005mb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > With 2.4.8-ac7, I get SCSI errors and the kernel fails to boot. If I
> > compile with APIC enabled and APIC on UP also enabled, it boots
> > cleanly
> 
> I'm getting similair errors on 2.4.8-ac7 on my P2B-S motherboard using
> the NEW AIC7xxx driver, the old isn't experiencing these problems. Further
> i've been getting these errors since 2.4.3.

There is a known BIOS irq routing table problem with a large number of Intel
BIOS boards with onboard adaptec controllers. The fact that making it use
the io-apic works suggest this is the same thing.

