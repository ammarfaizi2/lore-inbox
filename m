Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311264AbSCSOUZ>; Tue, 19 Mar 2002 09:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311267AbSCSOUP>; Tue, 19 Mar 2002 09:20:15 -0500
Received: from atlas.inria.fr ([138.96.66.22]:23761 "EHLO atlas.inria.fr")
	by vger.kernel.org with ESMTP id <S311262AbSCSOUA>;
	Tue, 19 Mar 2002 09:20:00 -0500
Message-Id: <200203191419.g2JEJfM07465@atlas.inria.fr>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Nicolas Turro <Nicolas.Turro@sophia.inria.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Nicolas.Turro@sophia.inria.fr (Nicolas Turro)
Subject: Re: amd nvidia and mem=nopentium
Date: Tue, 19 Mar 2002 15:19:40 +0100
X-Mailer: KMail [version 1.3]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16lx1N-0004NZ-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for your answer, Alan.

Le Vendredi 15 Mars 2002 20:05, Alan Cox a écrit :
> > Hi, i have system dual athlon  XP 1900+ system and a nvidia graphic board
> > : I need to use the mem=nopentium kernel parameter in order to run X
> > without crashes. I'd like to know :
> > 1- what are the consequences of  'mem=nopentium' ? Any performance loss ?
>
> Yes. On the whole probably not a lot. You are running XP not MP processors
> and the like so you are obviously not too worried about stability. You
> might want to see if it actually does crash without nopentium.

Well... In fact, i am really worried about stability, but i don't have much 
choice on the configuration. I have to choose between this config
and a dual 2.0 Ghz Xeon (RDRAM) which has roughtly the same perfs,
but which is 50% more expensive !

 Do you have pointers  showing stability problems when using
XP processor in a multiprocessor context ?

The Athlon actually crashes as soon as I start X with the nvidia board if i 
don't use the mem=nopentium option.
With a Matrox G450, i don't need this option...

> > i intend to use a gigabit ethernet adapter on this box.
> > 2- is there any fix going on that i should monitor ?
>
> Some gige cards don't seem to work with some dual athlon bioses. Other than
> that it should be fine

I've juste tested an Intel e1000 on it and achieved 900 Mbits/s with ttcp....
So i guess it works... I do some nfs benches right now to see if i can
reach the disk transfer limit (around 40 Mo/s for sequencial acces on a big 
file).

N. Turro
