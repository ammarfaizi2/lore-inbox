Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263676AbRFCQmg>; Sun, 3 Jun 2001 12:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263677AbRFCQm0>; Sun, 3 Jun 2001 12:42:26 -0400
Received: from 23dyn60.com21.casema.net ([213.17.93.60]:37896 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S263676AbRFCQmP>; Sun, 3 Jun 2001 12:42:15 -0400
Message-Id: <200106031641.SAA23743@cave.bitwizard.nl>
Subject: Re: rtl8139too in 2.4.5
In-Reply-To: <UTC200106021230.OAA182199.aeb@vlet.cwi.nl> from "Andries.Brouwer@cwi.nl"
 at "Jun 2, 2001 02:30:59 pm"
To: Andries.Brouwer@cwi.nl
Date: Sun, 3 Jun 2001 18:41:52 +0200 (MEST)
CC: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> My RTL8139 (Identified 8139 chip type 'RTL-8139A')
> was fine in 2.4.3 and doesnt work in 2.4.5.
> Copying the 2.4.3 version of 8139too.c makes things work again.
> 
> Since lots of people complained about this, I have not tried to
> debug - maybe a fixed version already exists?

We upgraded to 2.4.5-ac2 for some test, noted that the ethernet card
was agian in 6-packets-per-second mode (i.e. very slow) and then
continued to 2.4.5-ac4 where the driver was reverted to the one in
2.4.3. That worked.

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
