Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316500AbSGXCMl>; Tue, 23 Jul 2002 22:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316567AbSGXCMl>; Tue, 23 Jul 2002 22:12:41 -0400
Received: from genoa.broadwing.net ([65.90.208.154]:13199 "EHLO mail.ntr.net")
	by vger.kernel.org with ESMTP id <S316500AbSGXCMk>;
	Tue, 23 Jul 2002 22:12:40 -0400
Message-ID: <3D3E0F47.59CA2640@ntr.net>
Date: Tue, 23 Jul 2002 22:21:59 -0400
From: "Marco C. Mason" <mason@ntr.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.8-26mdk i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-kernel@vger.kernel.org
Subject: Re: [Patch] 2.5.27 sysctl
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is making the sysctl code acutally be written in C.
> > It wasn't mostly due to georgeous ommitted size array "forward
> > declarations". As a side effect it makes the table structure easier
to
> > deduce.

<snip>

> The comma changes are gratuitous, as pure ANSI C explicitly allows
such
> constructs. (It was intended to simplify automatic code generation, as

> well as for programmer ease to automatically deal with initializer
> lists.)

> >From the grammar section of the 2nd edition (ca. 1988) of K&R:
>        initializer:
>                assignment-expression
>                { initializer-list }
>                { initializer-list , }
>
> ...where initializer list is what one would expect.

Yeah, it's hard to see it as an "extension" when my copy of K&R (1978)
shows the same thing...

--marco


