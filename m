Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131762AbQK2RRX>; Wed, 29 Nov 2000 12:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131761AbQK2RRN>; Wed, 29 Nov 2000 12:17:13 -0500
Received: from windsormachine.com ([206.48.122.28]:62727 "EHLO
        router.windsormachine.com") by vger.kernel.org with ESMTP
        id <S131708AbQK2RQ5>; Wed, 29 Nov 2000 12:16:57 -0500
Message-ID: <3A2532E0.F72BFB02@windsormachine.com>
Date: Wed, 29 Nov 2000 11:46:25 -0500
From: Mike Dresser <mdresser@windsormachine.com>
Organization: Windsor Machine & Stamping
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: e.jokisch@u-code.de, linux-kernel@vger.kernel.org
Subject: Re: 2.4 test10 error reading from HP colorado 7/14 Gb tape
In-Reply-To: <3A24DDD1.D4731F6C@winealley.com> <00112912565800.21358@eckhard>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I  reported this a few weeks ago or so, it seems that HP 7/14's are not exactly
standard.  First is the proprietory tape size.  Second is that the drive doesn't
support locking the tape in, but reports it as possible.  At least, that's what i
gather from Jens's posting.

To be honest, I'm not sure the drives are worth fixing <grin>  Unreliable media,
unreliable tape drives.  I've got two dead out of 10, in under a year.  And half a
dozen tapes or so.  Plus, under 2.2.17+ide, the tape drive wouldn't restore tapes.
Something weird about the tape drive again.  Had to boot up under plain 2.2.17 to
read my tapes.

Eckhard Jokisch wrote:

> >
> > # tar -tvf  /dev/ht0
> > ide-tape: ht0: I/O error, pc = 8, key = 5, asc = 2c, ascq = 0
> >
> > A search on deja.com shows that I am not the only one to have
> > experienced this and that it did not occur with previous versions of
> > ide-tape.c. The same error occurs with a non-modular kernel build.
> >
> I experience the same with OnStream DI30 - but these errors occure in 2.2.17 as
> well. In my oppinion they show up in fewer cases with 2.4-test10.
> The error is not quite"stable" because it occures on different tape positions
> (filenames) when I retension the tape three aor four times befor writing to it.
>
> I checked the tapes on a Windows machine and they seem to be o.k..
>
> Eckhard Jokisch
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
