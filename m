Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262119AbSJNUeT>; Mon, 14 Oct 2002 16:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262146AbSJNUeT>; Mon, 14 Oct 2002 16:34:19 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:26630 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262119AbSJNUeS>;
	Mon, 14 Oct 2002 16:34:18 -0400
Date: Mon, 14 Oct 2002 13:40:26 -0700
From: Greg KH <greg@kroah.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: kbuild-devel <kbuild-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [kbuild-devel] linux kernel conf 0.9
Message-ID: <20021014204026.GB8366@kroah.com>
References: <3DAB23CB.5B52ECF1@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DAB23CB.5B52ECF1@linux-m68k.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 10:06:35PM +0200, Roman Zippel wrote:
> Hi,
> 
> At http://www.xs4all.nl/~zippel/lc/ you can find as usual the latest
> version of the new config system.
> I still haven't got a single mail from someone who tried it and didn't
> like it, what makes me a bit nervous :), so if you think something must
> be wrong, now is your last chance. Next version will go to Linus.

I get the following error on Red Hat 7.2:

g++ -O2 -Wall -g -fPIC -I/usr/lib/qt-2.3.1/include -c qconf.cc -o qconf.o
In file included from lkc.h:10,
                 from qconf.cc:22:
zconf.tab.h:8: conflicting types for `typedef union YYSTYPE YYSTYPE'
zconf.tab.h:8: previous declaration as `typedef union YYSTYPE YYSTYPE'
zconf.tab.h:38: conflicting types for `YYSTYPE zconflval'
zconf.tab.h:38: previous declaration as `YYSTYPE zconflval'

when trying to build the lkc package on it's own.

But when using the provided patch, make xconfig built the program just
fine.

Either way, nice job, I like the new format and the speed.

thanks,

greg k-h
