Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281270AbRKPKSz>; Fri, 16 Nov 2001 05:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281271AbRKPKSp>; Fri, 16 Nov 2001 05:18:45 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9221 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281270AbRKPKSc>; Fri, 16 Nov 2001 05:18:32 -0500
Subject: Re: Devlinks.  Code.  (Dcache abuse?)
To: neilb@cse.unsw.edu.au (Neil Brown)
Date: Fri, 16 Nov 2001 10:26:17 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15348.58752.207182.488419@notabene.cse.unsw.edu.au> from "Neil Brown" at Nov 16, 2001 09:08:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E164gCQ-0003YZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    A device special file is a gateway between a user (admin)
>    controlled name space (the filesystem) and a kernel imposed name
>    space (major/minor numbers) that recognises and imposes access
>    control (owner/group/permissions).
> 
> The (a) problem with this is that major/minor numbers are too limited,

Textual names have unsolved problems too
	1.	Who administers the namespace
	2.	When trademarks get entangled whats the disputes procedure

Do you want to create a situation where a future kernel is likely to be
forced to change a device naming because an "official" vendor driver appears
too and they demand the namespace and wave trademarks around ?

> A Devlink looks like a symlink with the "sticky" (S_ISVTX) bit set.
> Indeed, that is how it is stored on a filesystem.

That seems basically sound. I'm not sure about the devfs part but that
is a seperate matter. 

Alan

