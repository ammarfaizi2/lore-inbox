Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316250AbSEKSI4>; Sat, 11 May 2002 14:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316252AbSEKSIz>; Sat, 11 May 2002 14:08:55 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8979 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316250AbSEKSIv>; Sat, 11 May 2002 14:08:51 -0400
Subject: Re: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH] 2.5.14
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 11 May 2002 19:26:03 +0100 (BST)
Cc: gh@us.ibm.com (Gerrit Huizenga), ltd@cisco.com (Lincoln Dale),
        akpm@zip.com.au (Andrew Morton), alan@lxorguk.ukuu.org.uk (Alan Cox),
        dalecki@evision-ventures.com (Martin Dalecki),
        padraig@antefacto.com (Padraig Brady),
        aia21@cantab.net (Anton Altaparmakov),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.44.0205111047280.2355-100000@home.transmeta.com> from "Linus Torvalds" at May 11, 2002 11:04:45 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E176bZD-0008QD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > O_DIRECT is especially useful for applications which maintain their
> > own cache, e.g. a database.  And adding Async to it is an even bigger
> > bonus (another Oracleism we did in PTX).
> 
> The thing that has always disturbed me about O_DIRECT is that the whole
> interface is just stupid, and was probably designed by a deranged monkey
> on some serious mind-controlling substances [*].

Used with aio its extremely nice. Without the aio patches its a bit lacking
whenever readahead is useful

Alan
