Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131761AbRBNIgu>; Wed, 14 Feb 2001 03:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131716AbRBNIgl>; Wed, 14 Feb 2001 03:36:41 -0500
Received: from 13dyn76.delft.casema.net ([212.64.76.76]:32005 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129027AbRBNIg2>; Wed, 14 Feb 2001 03:36:28 -0500
Message-Id: <200102140835.JAA10246@cave.bitwizard.nl>
Subject: Re: Stale NFS handles on 2.4.1
In-Reply-To: <E14SovJ-0003H1-00@the-village.bc.nu> from Alan Cox at "Feb 13,
 2001 11:31:50 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 14 Feb 2001 09:35:59 +0100 (MET)
CC: "[Jakob _stergaard]" <jakob@unthought.net>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > The NFS clients are getting
> >  "Stale NFS handle"
> > messages every once in a while which will make a "touch somefile.o"
> > fail.
> 
> If they have the previous .o handle cached and it was removed on another
> client thats quite reasonable behaviour. NFS isnt coherent

As reported before, I see simliar stuff on an 2.2. SMP NFS client, and
an 2.2. NFS server.

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
