Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131887AbQKQLTN>; Fri, 17 Nov 2000 06:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131922AbQKQLSy>; Fri, 17 Nov 2000 06:18:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10586 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131887AbQKQLSw>; Fri, 17 Nov 2000 06:18:52 -0500
Subject: Re: APM oops with Dell 5000e laptop
To: brad@neruo.com (Brad Douglas)
Date: Fri, 17 Nov 2000 10:49:05 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), dax@gurulabs.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20001117001119Z131557-521+765@vger.kernel.org> from "Brad Douglas" at Nov 17, 2000 07:40:49 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wj4s-0000U0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't believe doing this just to make a Dell detect properly is the right way to go (regardless of my bias).  I think the best we can do build a list of the systems that are the same, but it's certainly not a preferred way.
> 
> Any suggestions?

The ideal approach is to ident and version id the compal bios. The DMI tables
can include more useful BIOS info but rarely do (you might want to dump all the
DMI tables in your box and see if you have a BIOS vendor/version)

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
