Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131578AbQKRKqy>; Sat, 18 Nov 2000 05:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131600AbQKRKqo>; Sat, 18 Nov 2000 05:46:44 -0500
Received: from 13dyn189.delft.casema.net ([212.64.76.189]:24583 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S131578AbQKRKq3>; Sat, 18 Nov 2000 05:46:29 -0500
Message-Id: <200011181016.LAA12939@cave.bitwizard.nl>
Subject: Re: RFC: "SubmittingPatches" text
In-Reply-To: <E13wX8W-0008Qt-00@the-village.bc.nu> from Alan Cox at "Nov 16,
 2000 10:04:02 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sat, 18 Nov 2000 11:16:15 +0100 (MET)
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Maybe also note that maintainers of given modules are much more likely to
> give feedback than Linus, also the [PATCH]: convention

Question: 

Should a submitter CC Linus or linux-kernel on the patch before having
gotten approval from a maintainer?

I'd say DO CC Linux-kernel, don't CC Linus. 

Otherwise Linus may get a patch that he doesn't know if it violates
the essential ideas behind some vague driver. And the message with it
could say: "As suggested by <driver-author>". 

If Linux-kernel and the driver-author don't have any objections to the
patch, send it to Linus and the driver author, keeping Linux-kernel
out of the loop, this time with a  note:

	"Linus: Reviewed by <driver-author> and Linux-kernel, 
	please apply". 

Note that Linus will not have read the previous discussion, so some of
the ideas of the patch may have to be repeated....

This is the way I'd like things to work. Feel free to disagree, and
try to convince me why it's wrong....

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
