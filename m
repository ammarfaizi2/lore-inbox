Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136077AbRDVMnZ>; Sun, 22 Apr 2001 08:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136078AbRDVMnP>; Sun, 22 Apr 2001 08:43:15 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:40207 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136077AbRDVMm7>; Sun, 22 Apr 2001 08:42:59 -0400
Subject: Re: light weight user level semaphores
To: alonz@nolaviz.org (Alon Ziv)
Date: Sun, 22 Apr 2001 13:44:46 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <041c01c0cb21$1dd520c0$910201c0@zapper> from "Alon Ziv" at Apr 22, 2001 01:41:04 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rJEP-0005l6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> All of this FD allocation stuff is truly distrurbing.
> This appears to be the one place where Win32 got it (almost) right---
> quite about every kernel object looks to userland just like an opaque
> handle, and the same operations apply to all of them.

Unix got this right, then AT&T broke it in System III. One very good reason
for pipe based semaphore stuff is precisely that it works in poll/select/SIGIO

Alan

