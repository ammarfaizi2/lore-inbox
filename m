Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129861AbRCCXdD>; Sat, 3 Mar 2001 18:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129860AbRCCXcn>; Sat, 3 Mar 2001 18:32:43 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25868 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129858AbRCCXcj>; Sat, 3 Mar 2001 18:32:39 -0500
Subject: Re: [PATCH] 2.4.2: cure the kapm-idled taking (100-epsilon)% CPU
To: fg@mandrakesoft.com (Francis Galiegue)
Date: Sat, 3 Mar 2001 23:35:34 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        jgarzik@mandrakesoft.com, kernel@linux-mandrake.com (Kernel list)
In-Reply-To: <Pine.LNX.4.21.0103040016050.922-100000@toy.mandrakesoft.com> from "Francis Galiegue" at Mar 04, 2001 12:19:07 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ZLYn-0004Jj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, from reading the source, I don't see how this can break APM... What=
>  am I
> missing?

If you've stopped kapm-idled from using cpu then you've stopped it from going
into the bios suspend one presumes.
