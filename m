Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264244AbRGCMDg>; Tue, 3 Jul 2001 08:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264215AbRGCMD0>; Tue, 3 Jul 2001 08:03:26 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:52485 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264214AbRGCMDL>; Tue, 3 Jul 2001 08:03:11 -0400
Subject: Re: [RFC] I/O Access Abstractions
To: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 3 Jul 2001 13:02:53 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010702235447.1201@smtp.wanadoo.fr> from "Benjamin Herrenschmidt" at Jul 03, 2001 01:54:47 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15HOtJ-0007cN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm more concerned about having all that space mapped permanently in
> kernel virtual space. I'd prefer mapping on-demand, and that would
> require a specific ioremap for IOs.

I have no problem with the idea of a function to indicate which I/O maps you
are and are not using. But passing resource structs around is way too heavy

Alan

