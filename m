Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315463AbSEHATe>; Tue, 7 May 2002 20:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315467AbSEHATc>; Tue, 7 May 2002 20:19:32 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26889 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315463AbSEHATb>; Tue, 7 May 2002 20:19:31 -0400
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
To: kaos@ocs.com.au (Keith Owens)
Date: Wed, 8 May 2002 01:37:38 +0100 (BST)
Cc: ionut@cs.columbia.edu (Ion Badulescu), linux-kernel@vger.kernel.org
In-Reply-To: <2658.1020816607@ocs3.intra.ocs.com.au> from "Keith Owens" at May 08, 2002 10:10:07 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E175FSc-0000WQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >- I think looking for kgcc before gcc is a bad idea. If you really
> >want something like that, make it look for kgcc-2.5 instead.
> 
> That came from one of the -ac trees.  No matter which order I use,
> somebody will want a different order and complain.  At least kbuild 2.5
> tells you what it is using, instead of silently defaulting to an
> unexpected value.

For 2.2 - for 2.4 using kgcc generally gets you egcs-1.1.2 which tends
to be a bad idea, and for 2.5 its a no go. I'd drop the kgcc search.

Alan
