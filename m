Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130171AbRBKUiM>; Sun, 11 Feb 2001 15:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130152AbRBKUiC>; Sun, 11 Feb 2001 15:38:02 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21262 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130171AbRBKUhu>; Sun, 11 Feb 2001 15:37:50 -0500
Subject: Re: [RFC] framework for fpu usage in kernel
To: manfred@colorfullife.com (Manfred Spraul)
Date: Sun, 11 Feb 2001 20:37:58 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        arjan@fenrus.demon.nl (Arjan van de Ven),
        dledford@redhat.com (Doug Ledford),
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <3A86F67D.53C1BD9B@colorfullife.com> from "Manfred Spraul" at Feb 11, 2001 09:30:53 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14S3Fy-0004y8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What if a drm module wants to use the fpu and then uses memcpy() after
> modifying the ftp registers?

Interesting question. Right now the answer is dont do that. Point noted

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
