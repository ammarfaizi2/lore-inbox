Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262442AbSJNUyw>; Mon, 14 Oct 2002 16:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262448AbSJNUyw>; Mon, 14 Oct 2002 16:54:52 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:2056 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262442AbSJNUyv>; Mon, 14 Oct 2002 16:54:51 -0400
Date: Mon, 14 Oct 2002 23:00:35 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Greg KH <greg@kroah.com>
cc: kbuild-devel <kbuild-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [kbuild-devel] linux kernel conf 0.9
In-Reply-To: <20021014204026.GB8366@kroah.com>
Message-ID: <Pine.LNX.4.44.0210142256290.338-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 14 Oct 2002, Greg KH wrote:

> I get the following error on Red Hat 7.2:
>
> g++ -O2 -Wall -g -fPIC -I/usr/lib/qt-2.3.1/include -c qconf.cc -o qconf.o
> In file included from lkc.h:10,
>                  from qconf.cc:22:
> zconf.tab.h:8: conflicting types for `typedef union YYSTYPE YYSTYPE'
> zconf.tab.h:8: previous declaration as `typedef union YYSTYPE YYSTYPE'
> zconf.tab.h:38: conflicting types for `YYSTYPE zconflval'
> zconf.tab.h:38: previous declaration as `YYSTYPE zconflval'
>
> when trying to build the lkc package on it's own.

Hmm, another bison version. :)
Anyway, I've just uploaded a fixed version.

> Either way, nice job, I like the new format and the speed.

Thanks.

bye, Roman

