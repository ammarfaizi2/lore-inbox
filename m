Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271723AbRICOvx>; Mon, 3 Sep 2001 10:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271728AbRICOvn>; Mon, 3 Sep 2001 10:51:43 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35090 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271723AbRICOv2>; Mon, 3 Sep 2001 10:51:28 -0400
Subject: Re: Editing-in-place of a large file
To: mcelrath+linux@draal.physics.wisc.edu (Bob McElrath)
Date: Mon, 3 Sep 2001 15:54:28 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010903094636.V23180@draal.physics.wisc.edu> from "Bob McElrath" at Sep 03, 2001 09:46:36 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15dv7M-0001po-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sounds like a possibility for the kernel to me.  As with most things,

But you have it backwards - things are not "could go in the kernel" things
are "could avoid being in kernel"

> passed around as a target for the video device, a source for a userspace
> program, and a source for DMA to disk)  They also have some special
> flags:
>     fcentl(fd, F_SETFL, FDIRECT); /* enables direct disk access */
>     open(filename, O_DIRECT);     /* likewise */
> See this page for details:
>     http://reality.sgi.com/cpirazzi_engr/lg/uv/disk.html

Andrea has this working on 2.4 + patches

