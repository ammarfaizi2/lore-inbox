Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264373AbUFDGe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbUFDGe1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 02:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265637AbUFDGe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 02:34:27 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:41526 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264373AbUFDGeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 02:34:24 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: lotsa oops - 2.6.5 (preempt + unable handle virutal address +
    more?)
X-Attribution: anupam
References: <E1BW7gZ-00066c-00@mail.kbs.net.au>
From: Anupam Kapoor <anupam.kapoor@veritas.com>
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAHlBMVEX29feBVUXQw8AoGxf5 
    9/v49/q2g23f2Nfx7/H7+v1tv7dGAAACQklEQVR4nGWSQW/UMBCFfUnZ3vBG+EyNWJ93LbX3aiLh
    21LFhR6zRQauvqS9FSS2/QEG5H/LG3uzKTCKnGS+eW/GicXTgxBiUda/o4KF+I88zU9Rm4e54Pjw
    vbXWKiNm0Hg2i5xHfJnNGr8VYm8PsWk8vx/jdgL2tfd+zp8c8/bC+6aYND0K3szA3pMvbj5120X7
    DLxMftvApc/55xUnZJCTV2nC4NratQwIKVu7SV2xopzTe9TLsNOrMEi76ciRF81NzvmagQq7As6J
    a0XjsF4WBccg2/NMyAmPha7QQio4VcDBgOiDXWNgudMMNgdA5KlroZDrEIDbiwr65Ih+t0ifyzDw
    Rl8dALlEJ7cQhEFhJtl+5XwCIHL7W54JQKl1e59Tok74vqe8GiYA5SnGJBJ93/UAqgI5SNVTmqyq
    Qg+7lQIt+wNwObl9BeoMYFmcqADa1x78vSroPHbeeboqgH2CXBJb5XJ4+vRNKjUUDZrflH0I/rvu
    l+TgYeXO1Z0LzyfrsuQDr2/zAeCoNPROTqHyM4ABjk7Lv0B23DYw+VTS+FZVkc4mq/Jt8Y8AHOgC
    CstnRxoe1iVWUBKPkRUtny59B4Grio+jNkPxwY/U+q7HweJD/UKPcTz20EabG0pb8fQYzTjGCaio
    tTanyYtoIvLjKlSzJdJw/tEISBnoUOMz3kY96gfBFQbXAXAZhxblFkezmoApCYBYKyrYaVZwl3+A
    iRWMUWBhXwzJAtSW5gC1FwoLwI3LZ6CjjjDDTZdZxvEPCh8u8qEw0iIAAAAASUVORK5CYII=
Date: Fri, 04 Jun 2004 11:56:37 +0530
In-Reply-To: <E1BW7gZ-00066c-00@mail.kbs.net.au> 
    (pods@dodo.com.au's message of "Fri, 4 Jun 2004 11:26:13 +0530")
Message-ID: <87fz9b96ua.fsf@seldon.vxindia.veritas.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

looks like you are using nvidia ?

anupam

"Pods" <pods@dodo.com.au> writes:

>    Hi, sorry for the not very descriptive subject.
>
>    I have a problem with linux 2.6.5, it crashes, a lot. Some times it
>    spews
>    out oops at me, sometimes i dotn know if it oopsed or not because the
>    machine doesnt respond.
>
>    I can reproduce this by several means, including playing a dvd,
>    compiling
>    firefox, mplayer or thunderbird and i can be doing something not quite
>    a
>    hard on the system such as browsing the web or chatting... It'll find
>    some
>    way to piss me off.
>
>    Now, i have supplied several oops, each on containing the full output
>    of
>    dmesg via the kernel logging daemon. I have also supplied my hardware
>    specs
>    (mobo + lspci -vvv) and out put of ver_linux?... All these files can
>    be
>    found @ [1]http://users.quickfox.org/~pods/linux-issues/.
>
>    I didnt want to post them here because each oops IIRC is different.
>    Just to
>    let you know if have tried several way in which to correct this.
>
>    * several different kernels ( 2.4.18-bf24, 2.4.26, 2.6.5 )
>    ** with ide shareirq
>    ** noapic
>    ** + apic
>    ** noacpi
>    ** + acpi
>    ** lots of other differences
>
>    * Recently i had turned to bios and have disabled many things
>    including apic
>    (just incase you where wondering, bios had mps @ 1.4)
>
>    If you would rather me add the very large amoung of oops to this
>    email, tell
>    me and i'll do so. Thanks in advance.
>
>    P.S Im not subscribed to the list, i may consider it depending on the
>    amount
>    of feedback i get and how involved i need to be, but for now i'd
>    rather if
>    people could CC me their response. Thank you
>    again.
>
>    ________________________________________________
>
>    Message sent using
>    Dodo Internet Webmail Server
>
>    -
>    To unsubscribe from this list: send the line "unsubscribe
>    linux-kernel" in
>    the body of a message to majordomo@vger.kernel.org
>    More majordomo info at  [2]http://vger.kernel.org/majordomo-info.html
>    Please read the FAQ at  [3]http://www.tux.org/lkml/
>
> References
>
>    1. http://users.quickfox.org/~pods/linux-issues/
>    2. http://vger.kernel.org/majordomo-info.html
>    3. http://www.tux.org/lkml/
