Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbQLOKeN>; Fri, 15 Dec 2000 05:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbQLOKdx>; Fri, 15 Dec 2000 05:33:53 -0500
Received: from p3E9C2193.dip.t-dialin.net ([62.156.33.147]:54797 "EHLO
	ntlinux1.mtg-marinetechnik.de") by vger.kernel.org with ESMTP
	id <S129324AbQLOKdm> convert rfc822-to-8bit; Fri, 15 Dec 2000 05:33:42 -0500
Message-ID: <3A39EC62.6AF06EA3@gmx.net>
Date: Fri, 15 Dec 2000 11:03:14 +0100
From: Richard Ems <r.ems@gmx.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18pre15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: autofs v4 on 2.2.18 ?
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

I posted the following mail to the autofs list but got no answer.


> Hi!
>
> I'm trying to get 2.2.18 running with autofs4 but had no succes till
> now.
> I patched 2.2.18 with autofs4-2.2.17-20001023.diff, the patch applied
> whitout errors.
> I also compiled and installed autofs-4.0.0pre9.
> But after rebooting I got in my logs:
>
> Dec 12 07:45:53 bingo automount[2309]: starting automounter version
> 4.0.0, path = /misc, maptype = file, mapnamDec 12 07:45:53 bingo
> automount[2309]: Map argc = 1
> Dec 12 07:45:53 bingo automount[2309]: Map argv[0] = /etc/auto.misc
> Dec 12 07:45:53 bingo modprobe: modprobe: Can't locate module none
> Dec 12 07:45:53 bingo automount[2316]: starting automounter version
> 4.0.0, path = /net, maptype = program, mapnDec 12 07:45:53 bingo
> automount[2316]: Map argc = 1
> Dec 12 07:45:53 bingo automount[2316]: Map argv[0] = /etc/auto.net
> Dec 12 07:45:53 bingo automount[2309]: >> mount: fs type none not
> supported by kernel
> Dec 12 07:45:53 bingo automount[2309]: mount(bind): bind_works = 0
> Dec 12 07:45:53 bingo automount[2309]: >> umount: /tmp/autoEDqCOf: not
> mounted
> Dec 12 07:45:53 bingo automount[2309]: using kernel protocol version 3
> Dec 12 07:45:53 bingo automount[2309]: using timeout 300 seconds; freq
> 75 secs
> Dec 12 07:45:53 bingo modprobe: modprobe: Can't locate module none
> Dec 12 07:45:53 bingo automount[2316]: >> mount: fs type none not
> supported by kernel
> Dec 12 07:45:53 bingo automount[2316]: mount(bind): bind_works = 0
> Dec 12 07:45:53 bingo automount[2316]: >> umount: /tmp/autodNmHzg: not
> mounted
> Dec 12 07:45:53 bingo automount[2316]: using kernel protocol version 3
> Dec 12 07:45:53 bingo automount[2316]: using timeout 300 seconds; freq
> 75 secs
> Dec 12 07:46:24 bingo automount[2316]: attempting to mount entry
> /net/diablo
> Dec 12 07:46:24 bingo automount[2329]: lookup(program): looking up
> diablo
> Dec 12 07:46:24 bingo automount[2329]: lookup(program): diablo ->
> -fstype=nfs,hard,intr,nodev,nosuid  ^I/home dDec 12 07:46:24 bingo
> automount[2329]: parse(sun): expanded entry:
> -fstype=nfs,hard,intr,nodev,nosuid  ^I/home
> Dec 12 07:46:24 bingo automount[2329]: parse(sun):
> dequote("fstype=nfs,hard,intr,nodev,nosuid") -> fstype=nfs,hDec 12
> 07:46:24 bingo automount[2329]: parse(sun): gathered options:
> fstype=nfs,hard,intr,nodev,nosuid
> Dec 12 07:46:24 bingo automount[2329]: parse(sun): dequote("/home") ->
> /home
> Dec 12 07:46:24 bingo automount[2329]: parse(sun):
> dequote("diablo:/home") -> diablo:/home
> Dec 12 07:46:24 bingo automount[2329]: parse(sun): multimount:
> diablo:/home on /home with options fstype=nfs,haDec 12 07:46:24 bingo
> automount[2329]: parse(sun): mounting root /net, mountpoint diablo/home,
> what diablo:/homDec 12 07:46:24 bingo automount[2329]: mount(nfs):
> root=/net name=diablo/home what=diablo:/home, fstype=nfs, oDec 12
> 07:46:24 bingo automount[2329]: mount(nfs): nfs
> options="hard,intr,nodev,nosuid", nosymlink=0
> Dec 12 07:46:24 bingo automount[2329]: mount(nfs): calling mkdir_path
> /net/diablo/home
> Dec 12 07:46:24 bingo automount[2329]: mount(nfs): mkdir_path
> diablo/home failed: Operation not permitted
>
> Should I wait for a 2.2.18 pathc from autofs4 ?
> Before trying 2.2.18 I was running (and I am still running!) 2.2.18pre15
> with autofs4 without any problems!
>
> Will autofs4 ever get into 2.2 ??? 2.2.19 ???
>
> Many thanks, richard

Many thanks again, richard


--
   Richard Ems
   ... e-mail: r.ems@gmx.net
   ... Fachbereich Informatik, Universität Hamburg

   Unix IS user friendly. It's just selective about who its friends are.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
