Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261294AbRENNCm>; Mon, 14 May 2001 09:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261238AbRENNCc>; Mon, 14 May 2001 09:02:32 -0400
Received: from 13dyn155.delft.casema.net ([212.64.76.155]:8717 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S261294AbRENNCR>; Mon, 14 May 2001 09:02:17 -0400
Message-Id: <200105141302.PAA14005@cave.bitwizard.nl>
Subject: Re: Minor numbers
In-Reply-To: <E14zDcI-0007TB-00@the-village.bc.nu> from Alan Cox at "May 14,
 2001 09:22:09 am"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 14 May 2001 15:02:08 +0200 (MEST)
CC: Alex Q Chen <aqchen@us.ibm.com>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > 255.  Has this limitation been some how addressed with 2.4?  256 devices
> > per module, sometimes is not enough, especially if you are in the SAN
> > environment; or when the 256 minors numbers are broken down to several
> 
> 2.4 is using 16bit dev_t in kernel still. Application space sees a much
> larger dev_t so we can make the move in 2.5 very easily
> 
> > work-around or is proposing a solution?  I believe that minor and major
> > numbers for SUN and AIX are both 16 bits each (32 bits dev_t).
> 
> 20:12 is more common

Which is major, which is minor?

I have one (private) driver that requires around 5000 minors.
(currently through some 20 majors) (Currently only just over half of
these are physically installed....)

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
