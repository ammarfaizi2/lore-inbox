Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbQKFTuT>; Mon, 6 Nov 2000 14:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129631AbQKFTuJ>; Mon, 6 Nov 2000 14:50:09 -0500
Received: from 4dyn150.delft.casema.net ([195.96.105.150]:49413 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129401AbQKFTt6>; Mon, 6 Nov 2000 14:49:58 -0500
Message-Id: <200011061949.UAA31584@cave.bitwizard.nl>
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <E13sqAB-0006RI-00@the-village.bc.nu> from Alan Cox at "Nov 6, 2000
 05:34:30 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 6 Nov 2000 20:49:49 +0100 (MET)
CC: Alon Ziv <alonz@usa.net>, David Woodhouse <dwmw2@infradead.org>,
        linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> A simple more generic solution is to do this

[....]

> 	if exists && is from this boot then && is right size
> 		read data into __persistent ELF section
> 	endif

Alan, why are you stating "if it's from this boot"? I can think that
maybe you want to keep stuff across boots too. Maybe once we're at it,
have two sections. One that is persistent across boots, the other
isn't.

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
*       Common sense is the collection of                                *
******  prejudices acquired by age eighteen.   -- Albert Einstein ********
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
