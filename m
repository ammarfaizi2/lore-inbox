Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129336AbRBVIfA>; Thu, 22 Feb 2001 03:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129700AbRBVIeu>; Thu, 22 Feb 2001 03:34:50 -0500
Received: from 13dyn58.delft.casema.net ([212.64.76.58]:30987 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129336AbRBVIeg>; Thu, 22 Feb 2001 03:34:36 -0500
Message-Id: <200102220834.JAA05896@cave.bitwizard.nl>
Subject: Re: [rfc] Near-constant time directory index for Ext2
In-Reply-To: <3A944C05.FC2B623A@transmeta.com> from "H. Peter Anvin" at "Feb
 21, 2001 03:15:17 pm"
To: "H. Peter Anvin" <hpa@transmeta.com>
Date: Thu, 22 Feb 2001 09:34:17 +0100 (MET)
CC: Martin Mares <mj@suse.cz>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Martin Mares wrote:
> > 
> > Hello!
> > 
> > > True.  Note too, though, that on a filesystem (which we are, after all,
> > > talking about), if you assume a large linear space you have to create a
> > > file, which means you need to multiply the cost of all random-access
> > > operations with O(log n).
> > 
> > One could avoid this, but it would mean designing the whole filesystem in a
> > completely different way -- merge all directories to a single gigantic
> > hash table and use (directory ID,file name) as a key,

Novell, NTFS, HFS all do this. 

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
