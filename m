Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282540AbRLBAqJ>; Sat, 1 Dec 2001 19:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282547AbRLBAqA>; Sat, 1 Dec 2001 19:46:00 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:781 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S282540AbRLBApt>; Sat, 1 Dec 2001 19:45:49 -0500
Date: Sat, 1 Dec 2001 16:56:27 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "[MOc]cda*mirabilos" <mirabilos@netcologne.de>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] task_struct colouring ...
In-Reply-To: <010501c17ac4$986acf80$25aefea9@ecce>
Message-ID: <Pine.LNX.4.40.0112011654550.1696-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Dec 2001, [MOc]cda*mirabilos wrote:

> > movl %esp, %eax
> > andl $-8192, %eax
> > movl (%eax), %eax
>
> Although I'm good in assembly but bad in gas,
> do you consider the middle line good style?
>
> Binary AND with a negative decimal number?

~N = -(N + 1)




- Davide


