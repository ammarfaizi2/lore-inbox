Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129573AbQLVSJC>; Fri, 22 Dec 2000 13:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129913AbQLVSIx>; Fri, 22 Dec 2000 13:08:53 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:35138 "EHLO
	amsmta06-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129573AbQLVSIn>; Fri, 22 Dec 2000 13:08:43 -0500
Date: Fri, 22 Dec 2000 19:45:32 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Pavel Machek <pavel@suse.cz>
cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: kapm-idled : is this a bug?
In-Reply-To: <20001221132800.A1398@bug.ucw.cz>
Message-ID: <Pine.LNX.4.21.0012221944520.15294-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Agree that it is different. But it confuses people to have two
> > idle-tasks. I suggest that we throw it one big pile, unless having a
> > separate apm idle task has a purpose. 
> 
> You can't do that. Doing it this way is _way_ better for system
> stability, because kidle-apmd sometimes dies due to APM
> bug. kidle-apmd dying is recoverable error; swapper dieing is as fatal
> as it can be.

Hmm.. Means two idle task then :)



	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
