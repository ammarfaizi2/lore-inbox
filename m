Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132562AbRDHN44>; Sun, 8 Apr 2001 09:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132563AbRDHN4q>; Sun, 8 Apr 2001 09:56:46 -0400
Received: from 4dyn180.delft.casema.net ([195.96.105.180]:54026 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S132562AbRDHN4f>; Sun, 8 Apr 2001 09:56:35 -0400
Message-Id: <200104081356.PAA24042@cave.bitwizard.nl>
Subject: Re: goodbye
In-Reply-To: <20010408132205.O805@mea-ext.zmailer.org> from Matti Aarnio at "Apr
 8, 2001 01:22:05 pm"
To: Matti Aarnio <matti.aarnio@zmailer.org>
Date: Sun, 8 Apr 2001 15:56:25 +0200 (MEST)
CC: kumon@flab.fujitsu.co.jp, Michael Peddemors <michael@linuxmagic.com>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio wrote:
> On Sun, Apr 08, 2001 at 02:10:52PM +0900, kumon@flab.fujitsu.co.jp wrote:
> > How about creating an additional ML,
> > the new ML (say LKML-DUL) is used to send mails from DUL to LKML, but
> > such mails are not sent to LMKL.
> 
> 	Layering and technology problem.
> 
> 	SMTP receiver does those RBL/DUL/ORBS analysis, and its policy
> 	control does not know where exactly the email is heading into
> 	(that is, the reception policy is system level, not by recipients.)

Then fix it!

SMTP receivers should have the option of inserting a header line
instead of blocking "bad" Emails. Then other layers can decide what to
do with this Email.

I really would like to run "ORBS" on my incoming-mail-server. However
I find it unacceptable to be rejecting Email from possibly legitimate
clients. So Adding an "relay is listed on orbs" line would allow me to
sort this into a low priority "probably spam" mailbox, just like I'd
do with those tagged as such by LKML.

After adding the header line, you could easily make majordomo do
special stuff with this Email, but having the header line probably
makes that unneccesary.

If you're willing to pay a small amount to make this happen, or if
you're willing to earn a few bucks by implementing this, stop by:

    http://www.cosource.com/cgi-bin/cos.pl/wish/info/402
and http://www.cosource.com/cgi-bin/cos.pl/wish/info/403

				Roger.

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
