Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143430AbRELA1W>; Fri, 11 May 2001 20:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143437AbRELA1M>; Fri, 11 May 2001 20:27:12 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:527 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S143430AbRELA0v>; Fri, 11 May 2001 20:26:51 -0400
Subject: Re: Linux 2.4.4-ac8 now with added correct EXTRAVERSION
To: andersg@0x63.nu
Date: Sat, 12 May 2001 01:22:42 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010512021351.A784@h55p111.delphi.afb.lu.se> from "andersg@0x63.nu" at May 12, 2001 02:13:51 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14yNBC-0001sV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Somewhere between ac5 and ac8 ipc broke, noticed that fakeroot stopped
> working, getting a function not implemented in msgget:
> 
> [pid  9812] msgget(667493921, IPC_CREAT|0x180|0600) = -1 ENOSYS (Function not implemented)

Looks you you compiled without SYS5 ipc support
> 

