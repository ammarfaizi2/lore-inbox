Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129583AbRCAO2U>; Thu, 1 Mar 2001 09:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129602AbRCAO2K>; Thu, 1 Mar 2001 09:28:10 -0500
Received: from opal.cs.tu-berlin.de ([130.149.17.5]:41948 "EHLO
	opal.cs.tu-berlin.de") by vger.kernel.org with ESMTP
	id <S129583AbRCAO1z>; Thu, 1 Mar 2001 09:27:55 -0500
Date: Thu, 1 Mar 2001 15:25:29 +0100 (MET)
From: Peter Daum <gator@cs.tu-berlin.de>
Reply-To: Peter Daum <gator@cs.tu-berlin.de>
To: <linux-kernel@vger.kernel.org>
Subject: Re: fat problem in 2.4.2
In-Reply-To: <E14X7eW-00049F-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0103011502050.23650-100000@swamp.bayern.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Feb 2001, Alan Cox wrote:

> > The bug with truncate in the fat filesystem that was present in 2.4.0,
> > and fixed with the 2.4.0-ac12 (or earlier) patch is still in the main
>
> It isnt a bug. The fix in 2.4-ac I've dropped. A program that assumes
> ftruncating a file large will work is broken.

In that case, why was it changed for FAT only? Ext2 will still
happily enlarge a file by truncating it.

If the behavior has to be changed, wouldn't it be better to first
give people a chance to get programs, that rely on the old
behavior fixed, before enforcing the change?

Staroffice (the binary-only version; the new "open source"
version is not yet ready for real-world use) for example
currently doesn't write to FAT filesystems anymore - which is
pretty annoying for people who need it.

Is there somewhere a patch for the current kernel?

Regards,

       Peter Daum

