Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129597AbQKFRJO>; Mon, 6 Nov 2000 12:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129222AbQKFRJE>; Mon, 6 Nov 2000 12:09:04 -0500
Received: from [195.63.194.11] ([195.63.194.11]:62475 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S129115AbQKFRI5>; Mon, 6 Nov 2000 12:08:57 -0500
Message-ID: <3A06F1C4.CB25FA8C@evision-ventures.com>
Date: Mon, 06 Nov 2000 19:00:36 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.16-1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <200011061631.eA6GVkw07051@pincoya.inf.utfsm.cl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> 
> David Woodhouse <dwmw2@infradead.org> said:
> > jas88@cam.ac.uk said:
> > >  Irrelevant. The current mixer settings don't matter: what matters is
> > > that the driver does not change them.
> 
> > It does matter. The sound driver needs to be able to _read_ the current
> > levels. Almost all mixer programs will start by doing this, to set the
> > slider to the correct place.
> 
> OK, how then using _2_ modules, data and worker:

People that's all designing for the sake of design.
And it's trying to solve a non existant problem:
Just load the damn module once and leave it there where it is.
Drivers are supposed to handle present hardware - if the hardware
is there - there should be a driver handling it as well.
The argument for saving some memmory is nonapplicable becouse in
the case of expected usage in the future you have anyway to assume that
in this futere there will be sufficient memmory for it there. And then
please remember that all possible space savings are in the granularity
of
pages!

Could some one add this to the FAQ ... please!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
