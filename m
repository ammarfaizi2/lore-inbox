Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbSKCKCO>; Sun, 3 Nov 2002 05:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261714AbSKCKCN>; Sun, 3 Nov 2002 05:02:13 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:6926 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id <S261295AbSKCKCN> convert rfc822-to-8bit;
	Sun, 3 Nov 2002 05:02:13 -0500
From: Nero <neroz@iinet.net.au>
To: George Staikos <staikos@kde.org>
Subject: Re: Kconfig (qt) -> Gconfig (gtk)
Date: Sun, 3 Nov 2002 20:08:01 +1100
User-Agent: KMail/1.4.6
References: <1036274342.16803.27.camel@irongate.swansea.linux.org.uk> <200211030943.13730.neroz@iinet.net.au> <200211022253.07606.staikos@kde.org>
In-Reply-To: <200211022253.07606.staikos@kde.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200211032008.01807.neroz@iinet.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Nov 2002 02:53 pm, George Staikos wrote:
> On November 2, 2002 17:43, Nero wrote:
> > thing. If you absolutely hate GTK+, there is menuconfig, and IIRC KDE
> > have their own [external] kernel configurator utility.
>
>    Please contact myself and/or Malte Starostik (kcmlinuz author) regarding
> the KDE kernel configurator.  We have full intentions to support the new
> system once it is in widespread use.  Support for the new system will not
> be in KDE 3.1 but it should be in KDE 3.2 if all goes as planned.
>
>    If anyone has some feedback regarding the design we would also be
> interested in that.
>
>
>    Additionally, to those who complain about Qt's size and dependencies:
>    1) The 16MB Qt .gz (13MB .bz2) contains much more than just the library.
> it contains Qt Designer, example code, full and complete documentation for
> the entire library, etc.  That's not obscene in comparison with gtk+ and
> all accompanying RAD tools etc.  If for some reason 16MB vs 8.5MB really
> hurts, contact Trolltech and ask them if they will split the package up for
> you.
>
>     2) Exactly what dependencies other than g++, yacc, and X11 devel
> libraries are you concerned about?  I'm not sure there are any others.  If
> you're really afraid of C++, I can assure you that it's not so scary, and
> you don't even have to look at the C++ code.  However if you must, there
> are tutorials available online.
>
>    Anyhow, I think it's great to see a kernel config system that can have a
> GUI implemented with stdio, curses, Xlib, GTK and Qt.  That's clearly the
> best plan and they should all be available to choose from.
>
> Thanks

I'm not scared of C++. Reducing dependancies on the kernel is important 
though. If you're configuring a kernel, you already have a C compiler 
installed, but perhaps not a C++ compiler. This was the issue with CML2 as I 
understand it, depending on Python. Not exactly the same issue, but it is the 
same idea. Many people often ask me why make menuconfig doesn't work - it's 
always because they didn't know they needed the ncurses library for it to 
work (it's a common question on IRC). More dependancies != Good. Once again, 
the only reason I think Qt is not a good choice is because it (for the 
moment) is a large download, takes a long time to compile, requires C++, and 
is not as common as Gtk 1.x yet. (I also don't see a problem with shipping 
both, but I'd say Linus wont like that idea).
