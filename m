Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275968AbRI1HyY>; Fri, 28 Sep 2001 03:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275969AbRI1HyO>; Fri, 28 Sep 2001 03:54:14 -0400
Received: from mailfarm.ipfnet.net ([195.211.129.222]:18954 "EHLO
	mailfarm.ipfnet.net") by vger.kernel.org with ESMTP
	id <S275968AbRI1HyI>; Fri, 28 Sep 2001 03:54:08 -0400
Date: Fri, 28 Sep 2001 09:54:29 +0200 (MET DST)
From: Thomas Glanzmann <tg@ipfnet.net>
X-X-Sender: sithglan@cssun.rrze.uni-erlangen.de
To: Jesper Juhl <juhl@eisenstein.dk>
cc: linux-kernel@vger.kernel.org
Subject: Re: OOM killer
In-Reply-To: <3BB427F1.5070403@eisenstein.dk>
Message-ID: <Pine.GSO.4.40.0109280950410.20899-100000@cssun.rrze.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

have look at the following posting some time ago:
http://uwsg.iu.edu/hypermail/linux/kernel/0003.2/0303.html

greetings Thomas,

--


On Fri, 28 Sep 2001, Jesper Juhl wrote:

> Alan Cox wrote:
>
> >>> shed:~# echo 0 >/proc/sys/vm/overcommit_memory
> >>> shed:~# cat /proc/sys/vm/overcommit_memory
> >>> 0
> >>
> >> ahh, I see. Well, you live and learn ;)
> >>
> >> I think I've got to do my research better before writing mails to lkml.
> >
> >
> > In part.
> >
> > The option you want is '2' which isnt implemented 8)
> >
> > 0	-	I don't care
> > 1	-	Use heuristics to guesstimate avoiding overcommit
>
>
> Thank you for that info :)
>
> I wrote a small test program that allocated memory in increasingly
> larger chunks, and I saw no major difference with a setting of "0" or
> "1", it seemed both settings allowed my program to allocate exactely the
> same amount of mem before ENOMEM was returned (I can send the test
> program on request).
>
> I'll be looking forward to a setting of "2" becomming available :)
>
>
> Best regards
> Jesper Juhl
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

