Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261744AbRE2UJc>; Tue, 29 May 2001 16:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261700AbRE2UJW>; Tue, 29 May 2001 16:09:22 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:55052 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261744AbRE2UJK>; Tue, 29 May 2001 16:09:10 -0400
Subject: Re: share memory between kernel and user space
To: fxian@fxian.jukie.net (Feng Xian)
Date: Tue, 29 May 2001 21:06:57 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0105291601160.28063-100000@tiger> from "Feng Xian" at May 29, 2001 04:04:43 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E154plZ-0004p3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there any way to share a piece of memory which is allocated in kernel
> space with a user space program? (don't use copy_to_user etc.)

mmap.

Take a look at drivers/sound where a lot of drivers do this
