Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S135321AbQK0Cly>; Sun, 26 Nov 2000 21:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S135372AbQK0Clo>; Sun, 26 Nov 2000 21:41:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14688 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S135321AbQK0Clb>; Sun, 26 Nov 2000 21:41:31 -0500
Subject: Re: [PATCH] modutils 2.3.20 and beyond
To: david@linux.com (David Ford)
Date: Mon, 27 Nov 2000 02:11:49 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (LKML),
        jmerkey@vger.timpanogas.org (Jeff V. Merkey)
In-Reply-To: <3A21A720.75A4EEB1@linux.com> from "David Ford" at Nov 26, 2000 04:13:20 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E140Dlm-0002bT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Anaconda will barf and require over 850+ changes to the scripts without
> > it.  If you look at the patch, you will note that it's a silent switch
> > that's only there to avoid a noisy error message from depmod.  It
> > actually does nothing other than set a flag that also does nothing.
> > -m simply maps to -F.
> 
> It's still a bad precedent.  Anaconda should have been written correctly in
> the first place.

I don't know if its an Anaconda issue or a limitation in the tools. Keith is
the modutils maintainer and its up to the Anaconda hackers to prove to him that
he has a problem so I think he is absolutely right in refusing to change it
until that is proven

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
