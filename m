Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132717AbRDNCvn>; Fri, 13 Apr 2001 22:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132727AbRDNCvd>; Fri, 13 Apr 2001 22:51:33 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:45470 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132717AbRDNCv1>;
	Fri, 13 Apr 2001 22:51:27 -0400
Date: Fri, 13 Apr 2001 22:51:25 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: John Fremlin <chief@bandits.org>, "Adam J. Richter" <adam@yggdrasil.com>,
        linux-kernel@vger.kernel.org
Subject: Re: PATCH(?): linux-2.4.4-pre2: fork should run child first
In-Reply-To: <Pine.LNX.4.31.0104131925370.11761-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0104132243190.26775-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 13 Apr 2001, Linus Torvalds wrote:

> 
> 
> On 14 Apr 2001, John Fremlin wrote:
> >
> >					. In fact, if you think
> > fork+exec is such a big performance hit why not go for spawn(2) and
> > have Linus and Al jump on you? ;-)
> 
> spawn() is trivial to implement if you want to. I don't think it's all
> that much more interesting than vfork()+execve(), though.

Or faster, for that matter...

