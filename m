Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265668AbSKAJtX>; Fri, 1 Nov 2002 04:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265671AbSKAJtX>; Fri, 1 Nov 2002 04:49:23 -0500
Received: from uucp.cistron.nl ([62.216.30.38]:59655 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S265668AbSKAJtW>;
	Fri, 1 Nov 2002 04:49:22 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: What's left over.
Date: Fri, 1 Nov 2002 09:55:13 +0000 (UTC)
Organization: A poorly-maintained Debian GNU/Linux InterNetNews site
Message-ID: <aptj21$jhs$3@ncc1701.cistron.net>
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com> <Pine.GSO.4.21.0210302135150.13031-100000@weyl.math.psu.edu> <20021031225729.GD4331@elf.ucw.cz> <1036103335.25512.40.camel@bip>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1036144513 20028 62.216.29.197 (1 Nov 2002 09:55:13 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1036103335.25512.40.camel@bip>,
Xavier Bestel  <xavier.bestel@free.fr> wrote:
>Le jeu 31/10/2002 à 23:57, Pavel Machek a écrit :
>
>> This seems like a pretty common situation to me, and current solutions
>> are not nice. [I guess ~/bin/ with --x and
>> ~/bin/my-secret-password-only-jarka-and-mj-knows/phonebook would solve
>> the problem, but...!]
>
>Can't even this be spied from /proc/*/fd ?

Or ptrace, /proc/pid/mem, etc. If you can execute a binary, it
has to be loaded into memory in a process running as you, so
you can read it.

Mike.

