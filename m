Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291141AbSBGPA1>; Thu, 7 Feb 2002 10:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291151AbSBGPAH>; Thu, 7 Feb 2002 10:00:07 -0500
Received: from Expansa.sns.it ([192.167.206.189]:35090 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S291141AbSBGO7x>;
	Thu, 7 Feb 2002 09:59:53 -0500
Date: Thu, 7 Feb 2002 15:59:53 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Oleg Drokin <green@namesys.com>
cc: reiserfs-dev@namesys.com, <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-dev] oops with reiserfs and kernel 2.5.4-pre1 on
 sparc64
In-Reply-To: <20020207130356.A18577@namesys.com>
Message-ID: <Pine.LNX.4.44.0202071557350.27176-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IT says that the kernel BUG is at buffer.c at line 2243; that is:

 /* Size must be within 512 bytes and PAGE_SIZE */
        if (size < 512 || size > PAGE_SIZE)
                BUG();

Luigi

On Thu, 7 Feb 2002, Oleg Drokin wrote:

> Hello!
>
> On Thu, Feb 07, 2002 at 10:58:27AM +0100, Luigi Genoni wrote:
>
> > > Can any of sparc64 people comment on what kind of exception will one
> > > get for __builtin_trap?
> > > Second BUG() seems to be out of the question, though.
> > > Do you have CONFIG_DEBUG_BUGVERBOSE enabled?
> > No, I have not
> If you'd enable it, you'd get a message on a next crash, where this BUG()
> happened exactly (so that we can verify my guess)
>
> Bye,
>     Oleg
>

