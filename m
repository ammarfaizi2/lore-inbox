Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312783AbSDBFFY>; Tue, 2 Apr 2002 00:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312786AbSDBFFP>; Tue, 2 Apr 2002 00:05:15 -0500
Received: from www.wen-online.de ([212.223.88.39]:35851 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S312783AbSDBFFI>;
	Tue, 2 Apr 2002 00:05:08 -0500
Date: Tue, 2 Apr 2002 06:06:59 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: -aa VM splitup
In-Reply-To: <Pine.LNX.4.21.0204012024440.8540-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.10.10204020548230.451-100000@mikeg.wen-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Apr 2002, Marcelo Tosatti wrote:

> On Mon, 1 Apr 2002, Mike Galbraith wrote:
> 
> <snip>
> 
> > It's the buffer.c changes (the ones I'm most interested in:) that are
> > causing my disk woes.  They look like they're in right, but are causing
> > bad (synchronous) IO behavior for some reason.  I have tomorrow yet to
> > figure it out.
> 
> Just to make sure: You mean the buffer.c changes alone (pre4 -> pre5) are
> causing bad synchronous IO behaviour for you ? 

I'm working out of 2.5, not 2.4.  I'm going to test 2.4.19pre5
and aa to make sure they don't show this behavior.. seriously
doubt that they will.

	-Mike

