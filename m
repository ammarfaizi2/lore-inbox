Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbQJ0OUy>; Fri, 27 Oct 2000 10:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129077AbQJ0OUo>; Fri, 27 Oct 2000 10:20:44 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2920 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129066AbQJ0OUZ>; Fri, 27 Oct 2000 10:20:25 -0400
Subject: Re: [PATCH] cpu detection fixes for test10-pre4
To: hpa@zytor.com (H. Peter Anvin)
Date: Fri, 27 Oct 2000 15:21:14 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8snfgq$uvr$1@cesium.transmeta.com> from "H. Peter Anvin" at Oct 19, 2000 11:45:46 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13pANf-0004Va-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >   - make Pentium IV and other post-P6 processors use the "i686"
> >     family name (same fix as the system_utsname.machine init fix
> >     which went into include/asm-i386/bugs.h in test10-pre4)
> > 
> 
> We should never have used anything but "i386" as the utsname... sigh.

Its questionable if we should include the 'i'

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
