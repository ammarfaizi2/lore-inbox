Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261744AbREPBBa>; Tue, 15 May 2001 21:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261746AbREPBBU>; Tue, 15 May 2001 21:01:20 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:36357 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S261743AbREPBBN>; Tue, 15 May 2001 21:01:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: LANANA: To Pending Device Number Registrants
Date: Wed, 16 May 2001 03:01:49 +0200
X-Mailer: KMail [version 1.2]
Cc: "H. Peter Anvin" <hpa@transmeta.com>,
        James Simmons <jsimmons@transvirtual.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0105151345410.2569-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0105151345410.2569-100000@penguin.transmeta.com>
MIME-Version: 1.0
Message-Id: <01051603014903.00406@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 May 2001 22:51, Linus Torvalds wrote:
> On Tue, 15 May 2001, Alexander Viro wrote:
> > If you want them all to inherit it - inherit from mountpoint.
>
> ..which is exactly what the device node ends up being. The implicit
> mount-point.
>
> And which point, btw, it is completely indistinguishable to user
> space whether the thing is implemented as a full filesystem, or
> whether it's just that the device node exports a simple "lookup()"
> that it passes down to the device driver. So this is also the point
> where it becomes nothing but an implementation issue, and as such
> it's much less contentious.
>
> Done right, they'll be automatic mount-points

Sounds like "treat it like a file and it acts like a file, treat it 
like a directory and it acts like a directory".

--
Daniel
