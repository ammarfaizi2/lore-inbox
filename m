Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273065AbRJNBYt>; Sat, 13 Oct 2001 21:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273108AbRJNBYj>; Sat, 13 Oct 2001 21:24:39 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28169 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273065AbRJNBY2>; Sat, 13 Oct 2001 21:24:28 -0400
Subject: Re: Maximum size of ext2 files on ia32 is?
To: hpa@zytor.com (H. Peter Anvin)
Date: Sun, 14 Oct 2001 02:30:40 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9qaioq$5vb$1@cesium.transmeta.com> from "H. Peter Anvin" at Oct 13, 2001 04:29:30 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15sa6y-0004Pt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 2G.  But my version of 7.2 Suse doesn't.  I take it this is a recent update
> > to the file utils?
> 
> No, it's a matter of if the distributor, who compiled fileutils,
> compiled with -D_FILE_OFFSET_BITS=64 or not.
> 

Well grep isnt actually gnu fileutils but the point is mostly valid. grep
also uses mmap so there are some other minor points of consideration
