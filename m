Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313747AbSDTAN1>; Fri, 19 Apr 2002 20:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314285AbSDTAN0>; Fri, 19 Apr 2002 20:13:26 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22790 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313747AbSDTANZ>; Fri, 19 Apr 2002 20:13:25 -0400
Subject: Re: [PATCH] Re: SSE related security hole
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 20 Apr 2002 01:31:08 +0100 (BST)
Cc: hpa@zytor.com (H. Peter Anvin), bgerst@didntduck.org, andrea@suse.de,
        ak@suse.de, linux-kernel@vger.kernel.org, jh@suse.cz
In-Reply-To: <Pine.LNX.4.44.0204191708360.6542-100000@home.transmeta.com> from "Linus Torvalds" at Apr 19, 2002 05:09:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16yimS-0008GB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, MMX should arguably be initialized with "emms", so the proper
> sequence migth be something like

Does emms make any guarantees about the register state ?
