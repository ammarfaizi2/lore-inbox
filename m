Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132722AbRDNCak>; Fri, 13 Apr 2001 22:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132726AbRDNCab>; Fri, 13 Apr 2001 22:30:31 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:53521 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132717AbRDNCaT>; Fri, 13 Apr 2001 22:30:19 -0400
Date: Fri, 13 Apr 2001 19:29:20 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: John Fremlin <chief@bandits.org>
cc: "Adam J. Richter" <adam@yggdrasil.com>, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH(?): linux-2.4.4-pre2: fork should run child first
In-Reply-To: <m2g0fc6ybj.fsf@boreas.yi.org.>
Message-ID: <Pine.LNX.4.31.0104131925370.11761-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 14 Apr 2001, John Fremlin wrote:
>
>					. In fact, if you think
> fork+exec is such a big performance hit why not go for spawn(2) and
> have Linus and Al jump on you? ;-)

spawn() is trivial to implement if you want to. I don't think it's all
that much more interesting than vfork()+execve(), though.

		Linus

