Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281902AbRKZP5o>; Mon, 26 Nov 2001 10:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281896AbRKZP5e>; Mon, 26 Nov 2001 10:57:34 -0500
Received: from [195.66.192.167] ([195.66.192.167]:27154 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S281895AbRKZP5T>; Mon, 26 Nov 2001 10:57:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Kernel Releases
Date: Mon, 26 Nov 2001 17:55:49 -0200
X-Mailer: KMail [version 1.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0111261301390.1491-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0111261301390.1491-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Message-Id: <01112617554900.01035@manta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 November 2001 13:02, Rik van Riel wrote:
> On Mon, 26 Nov 2001, Ian Stirling wrote:
> > However, I for one never run a -pre kernel.
> >
> > I don't run -pre, because rightly or wrongly, I've got the impression
> > that these get even less testing than releases.
>
> I think the opening sentence of your email states
> the reason for that pretty well.

The only way we can get good testing for new kernels is to stop using
-preN prefix in development branch (2.5.x). Just increment that 'x'.

This will eliminate 'people waiting for final 2.5.N' problem.
(2.5 is unstable, so it's normal for it to break even in silly ways
as code gets patched/rewritten)

We can't do that for 2.4, for 2.4 scenario is:

Joe User: I see this oops in 2.4.18!
Maintainer: please try this 2.4.19pre1 I made for you
J: still oopses
M: hmm... try this 2.4.19pre2
J: YES YES YES it works now thanks
   - several days have passed, M may have some afterthoughts -
   - and updated preN's, can feed them to J etc... -
M: Do you see anything unusual since pre2?
J: No
M: He he me is cool, let's announce 2.4.19
--
vda
