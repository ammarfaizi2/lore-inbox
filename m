Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288873AbSAERDn>; Sat, 5 Jan 2002 12:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288874AbSAERDd>; Sat, 5 Jan 2002 12:03:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61708 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288873AbSAERD0>; Sat, 5 Jan 2002 12:03:26 -0500
Subject: Re: Patch: linux-2.5.2-pre8/fs/intermezzo kdev_t compilation fixes
To: adam@yggdrasil.com (Adam J. Richter)
Date: Sat, 5 Jan 2002 17:13:54 +0000 (GMT)
Cc: braam@clusterfs.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020105045311.A24785@baldur.yggdrasil.com> from "Adam J. Richter" at Jan 05, 2002 04:53:11 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16MuOI-0000MI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	In the long term, the Intermezzo team may want to look into
> whether kdev_t will reliably not use the most significant bit of
> an int (the sign bit), which seems to be the assumption in some of
> the error handling code.  I don't think that problem is imminent,
> however, as I think the currently planned kdev_t expansion is only
> to twenty bits.

12:20 = 32bits
