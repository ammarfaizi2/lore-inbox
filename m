Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267564AbRG2ISc>; Sun, 29 Jul 2001 04:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267565AbRG2ISW>; Sun, 29 Jul 2001 04:18:22 -0400
Received: from 20dyn97.com21.casema.net ([213.17.90.97]:2321 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S267564AbRG2ISO>; Sun, 29 Jul 2001 04:18:14 -0400
Message-Id: <200107290817.KAA28266@cave.bitwizard.nl>
Subject: Re: "oversized" files
In-Reply-To: <E15M6LP-0005NU-00@the-village.bc.nu> from Alan Cox at "Jul 16,
 2001 12:15:19 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sun, 29 Jul 2001 10:17:56 +0200 (MEST)
CC: Aaron Smith <yoda_2002@yahoo.com>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Alan Cox wrote:

> > I have a file that is approximately 3.25GB and my system keeps
> > bitching about "Value too large for defined data type."  Is there
> > any way to stop this?  Since I'm sure you're wondering why I have a
> > file that large, I'm using it via loopback as my MP3 partition, so I
> > can remove it fairly quick if the need should ever arise.
 
> You need a 2.4 kernel and you need to be using NFSv3 to handle files >2Gb

But the error message he posted is mostly from local apps. You need
a  set of apps compiled with recent GLIBC to be able to handle files 
bigger than 2G. 

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
