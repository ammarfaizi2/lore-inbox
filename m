Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311752AbSETG3u>; Mon, 20 May 2002 02:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312254AbSETG3t>; Mon, 20 May 2002 02:29:49 -0400
Received: from violet.setuza.cz ([194.149.118.97]:58641 "EHLO violet.setuza.cz")
	by vger.kernel.org with ESMTP id <S311752AbSETG3t>;
	Mon, 20 May 2002 02:29:49 -0400
Subject: Re: No PTRACE_READDATA for archs other than SPARC?
From: Frank Schaefer <frank.schafer@setuza.cz>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20020519.214053.19164382.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 20 May 2002 08:29:50 +0200
Message-Id: <1021876190.250.7.camel@ADMIN>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-05-20 at 06:40, David S. Miller wrote:
>    From: Pradeep Padala <ppadala@cise.ufl.edu>
>    Date: Sun, 19 May 2002 23:08:36 -0400 (EDT)
> 
>       I was trying to understand ptrace code in kernel. It seems there's
>    no PTRACE_READDATA for architectures other than sparc and sparc64.
>    There's a function named ptrace_readdata() in kernel/ptrace.c but I
>    couldn't find a way to invoke it from user space. Is the feature
>    missing? or Is it intended?
> 
> Only Sparc implements this, that is correct.

... and that's the reason why GDB don't support follow-fork-mode for the
intel pltform - right? ( I had a related thread on the gdb mailing list
not soo long ago. )

Frank


