Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291913AbSBNVZn>; Thu, 14 Feb 2002 16:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291918AbSBNVZe>; Thu, 14 Feb 2002 16:25:34 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46855 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291913AbSBNVZ2>; Thu, 14 Feb 2002 16:25:28 -0500
Subject: Re: fsync delays for a long time.
To: akpm@zip.com.au (Andrew Morton)
Date: Thu, 14 Feb 2002 21:38:53 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        moibenko@fnal.gov (Alexander Moibenko), linux-kernel@vger.kernel.org
In-Reply-To: <3C6C2A39.38ED19B1@zip.com.au> from "Andrew Morton" at Feb 14, 2002 01:20:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16bTaf-0001DX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> there.  Optimal.  Note that it implements "only sync the stuff which was
> dirty on entry" semantics.
> 
> But msync() is a different kettle of fish.  It calls file_fsync(), which
> syncs the entire device, livelockably.  Are you sure `solid' is not
> using msync?

Could be. I'm going on second hand reports here. 
