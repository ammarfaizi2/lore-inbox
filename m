Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131425AbQIBTN6>; Sat, 2 Sep 2000 15:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131420AbQIBTNr>; Sat, 2 Sep 2000 15:13:47 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:55563 "EHLO neon-gw.transmeta.com") by vger.kernel.org with ESMTP id <S131402AbQIBTNc>; Sat, 2 Sep 2000 15:13:32 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: error in arch/i386/kernel/ptrace.c (subtle)
Date: 2 Sep 2000 12:01:16 -0700
Organization: Transmeta Corporation
Message-ID: <8orips$bbe$1@penguin.transmeta.com>
References: <20000902155021.51C9E4917@pornstar.not.very.secure.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20000902155021.51C9E4917@pornstar.not.very.secure.org>,
Silvio Cesare <silvio@big.net.au> wrote:
>
>My fix would be to change orig_eax to -1 if the eip register is modified.
>Thus the signal handling code wouldnt think it needed to restart any syscalls.
>This is untested code btw.

Looks like a good fix to me..

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
