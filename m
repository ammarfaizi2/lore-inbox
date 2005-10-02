Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbVJBNbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbVJBNbU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 09:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbVJBNbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 09:31:20 -0400
Received: from nproxy.gmail.com ([64.233.182.197]:3316 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750991AbVJBNbT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 09:31:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mdtClRWS8piOWISYU5xUg0pYnZMGDxV775SiuqCuThTA5Bnr4xnmpJdHi8zlOpsrSxBYcaAA8c1TGL697NMzRDY4ykpw98PM1dLqsvBLKieZOSljmHoJAUyNbFy+bWkoTZKEadFnvd/EQPMzyp4lJXWIDM3EUfRZym2Ar8cYzbg=
Message-ID: <40f323d00510020631o53f58474j6b6cea1656387599@mail.gmail.com>
Date: Sun, 2 Oct 2005 15:31:18 +0200
From: Benoit Boissinot <bboissin@gmail.com>
Reply-To: Benoit Boissinot <bboissin@gmail.com>
To: lokum spand <lokumsspand@hotmail.com>
Subject: Re: A possible idea for Linux: Save running programs to disk
Cc: mike@concannon.net, linux-kernel@vger.kernel.org
In-Reply-To: <BAY105-F2270EEA37B83483AE53063A48E0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <433F0BF1.2020900@concannon.net>
	 <BAY105-F2270EEA37B83483AE53063A48E0@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/05, lokum spand <lokumsspand@hotmail.com> wrote:
> >From: Michael Concannon <mike@concannon.net>
> >To: Arjan van de Ven <arjan@infradead.org>
> >CC: lokum spand <lokumsspand@hotmail.com>, linux-kernel@vger.kernel.org
> >Subject: Re: A possible idea for Linux: Save running programs to disk
> >Date: Sat, 01 Oct 2005 18:21:37 -0400
> >
> >Arjan van de Ven wrote:
> >
> >>there is a LOT of state though.. the moment you add networking in the
> >>picture the amount of state just isn't funny anymore. Your X example is
> >>a good one as well...
> >>
> >>
> >There are a few cluster/parallel computing libraries out there that are
> >starting to allow "process migration"...
> >
> >One would assume that "saving it to a disk" is simply a degenerate case of
> >migrating the process...
> >
> >Presuming they have process migration working (and it seemed close a while
> >ago when I last looked), saving to a file might already be supported...
> >I'd google "process migration" and you are likely to find a lot of
> >discussion on this topic...
> >
> >/mike
> >
> >
>
> In fact moving processes from one machine to another would be a brilliant
> feature at my work, since we run fairly large and time-consuming simulations
> on electronic circuits. If the kernel could natively support bouncing jobs
> back and forth, that would really be something. Since we simulate with
> proprietary software, I suppose we can't rely on the simulator being
> rewritten to support such special libraries.
>
> Does any other Unix variant have process bouncing already?
>
You can have a look at kerrighed or openssi. They have modified
kernels who features process migration (and checkpointing for
kerrighed).

regards,

Benoit
