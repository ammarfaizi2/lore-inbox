Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135727AbRDXTuX>; Tue, 24 Apr 2001 15:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135728AbRDXTuO>; Tue, 24 Apr 2001 15:50:14 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21518 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135727AbRDXTuJ>; Tue, 24 Apr 2001 15:50:09 -0400
Subject: Re: BUG: Global FPU corruption in 2.2
To: zandy@cs.wisc.edu (Victor Zandy)
Date: Tue, 24 Apr 2001 20:51:19 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <cpxoftmqf9d.fsf@goat.cs.wisc.edu> from "Victor Zandy" at Apr 24, 2001 02:17:18 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14s8qH-0002oP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> > The preferable one for performance is certainly to backport the 2.4 changes
> 
> Is it any more substantial than changing all uses of the ptrace flags
> to the new variable?

It affects asm blocks and offsets on some ports. Its not too bad tho

