Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264944AbSKRXAV>; Mon, 18 Nov 2002 18:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264940AbSKRXAV>; Mon, 18 Nov 2002 18:00:21 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:20361 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265012AbSKRXAP>; Mon, 18 Nov 2002 18:00:15 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 18 Nov 2002 15:07:40 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Grant Taylor <gtaylor+lkml_cjiia111802@picante.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
In-Reply-To: <200211182204.gAIM47mU030748@habanero.picante.com>
Message-ID: <Pine.LNX.4.44.0211181505320.979-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Grant Taylor wrote:

> Ulrich Drepper writes:
>
> >> epoll does hook f_op->poll() and hence uses the asm/poll.h bits.
>
> > It does today. We are talking about "you promise that this will be
> > the case ever after or we'll cut your head off".
> > [...]
> > it is not you who has to deal with the fallout of a change when it
>
> Maybe Davide wouldn't, but *I* do; my project at work runs over epoll,
> and interface changes would require rework by me.
>
> Sensible interface changes in the future won't bother me.  I don't
> expect anything in the future nearly as earth-shattering as this
> current driver/ioctl->syscall transition.

epoll basically born now, and IMHO is very important to get the interface
stable right now. Later changes will be a real pain in the *ss. So I'm
gradually more convinced to have epoll to have its own bits and data
structure.




- Davide


