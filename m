Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129857AbQKVSiZ>; Wed, 22 Nov 2000 13:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129787AbQKVSiP>; Wed, 22 Nov 2000 13:38:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34412 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S129625AbQKVSiG>; Wed, 22 Nov 2000 13:38:06 -0500
Subject: Re: Linux 2.4.0test11-ac1
To: hpa@transmeta.com (H. Peter Anvin)
Date: Wed, 22 Nov 2000 18:06:04 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), macro@ds2.pg.gda.pl,
        hpa@zytor.com (H. Peter Anvin), mingo@chiara.elte.hu (Ingo Molnar),
        linux-kernel@vger.kernel.org
In-Reply-To: <3A1C0A4A.62694193@transmeta.com> from "H. Peter Anvin" at Nov 22, 2000 10:02:50 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13yeHW-0006GT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >  And suddenly certain i486 systems do not work anymore?  Well, I haven't
> > i486 is an intel processor
> > 
> ... but doesn't announce itself as such.

Depends which stepping. We can check for and allow 'unknown' vendor too.
The socket7 chips all have cpuid or other id schemes.

Alan



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
