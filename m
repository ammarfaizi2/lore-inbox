Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131886AbRDWJgk>; Mon, 23 Apr 2001 05:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131986AbRDWJgd>; Mon, 23 Apr 2001 05:36:33 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14852 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131886AbRDWJgZ>; Mon, 23 Apr 2001 05:36:25 -0400
Subject: Re: Kernel hang on multi-threaded X process crash
To: manuel@mclure.org (Manuel McLure)
Date: Mon, 23 Apr 2001 10:38:11 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010422230014.A979@ulthar.internal.mclure.org> from "Manuel McLure" at Apr 22, 2001 11:00:14 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rcnO-0007fb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Strange trace but it looks like a bug in the -ac experimental multithreaded
core dump patches. I've got a couple of other reports consistent with them
being broken somewhere 

Does it have to be something like mozilla (xmms also probably breaks it) that
does this. If so I suspect its specific to multithreaded apps and its a bug
in the core dump changes.

If so I guess I revert them


