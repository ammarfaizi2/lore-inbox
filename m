Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273305AbRJYNGx>; Thu, 25 Oct 2001 09:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273333AbRJYNGo>; Thu, 25 Oct 2001 09:06:44 -0400
Received: from Expansa.sns.it ([192.167.206.189]:18699 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S273305AbRJYNGk>;
	Thu, 25 Oct 2001 09:06:40 -0400
Date: Thu, 25 Oct 2001 15:06:51 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Marton Kadar <marton.kadar@freemail.hu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: concurrent VM subsystems
In-Reply-To: <freemail.20010925100655.37794@fm3.freemail.hu>
Message-ID: <Pine.LNX.4.33.0110251458020.6694-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This proposal came out two or three times.
Alan said "too ugly for words".

But the point is that when you are managing a complex project like the
Linux Kernel, you have to make choices, the VM is one of the think
that the tree manteiner has to make a choice about.

Two VM for the same kernel is nonsense, also as a configuration option.

In fact, here is the difference beetwen a coordinate and managed project,
and the "lets' put all inside" approach.


That said.
Those two VM are good, but for different use, and different HW.
It is a choice also which main use the kernel should address as a target.

I already exposed my opinion, and both Andrea and Rik know it very well.
The VM for servers needs to be predictable, for desktops needs to be as
fast as possible, also if it is a little less predictable and stable (who
cares if you reboot you desktop once every two days?).

Linus and Alan do chice for their tree what they want to get as a target,
and which VM approach they want to develop.

To have competition this way is also good, because there can also be
cooperation and compenetration.

Two VM as optional choice for one kernel is a bad approach, and is not
metodologically correct. (as a paradox, so let's have two VFS, two network
layers...)

Luigi



On Thu, 25 Oct 2001, Marton Kadar wrote:

> Just an idea from an absolute layman who keeps
> an eye on Kernel Traffic:
>
> Isn't it possible to include both VM approaches in the
> kernel sources? It would be nice to be able to choose
> at compile time through a configuration option.
> Perhaps Andrea Arcangeli's version could be marked
> experimental.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

