Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261515AbSKCAKp>; Sat, 2 Nov 2002 19:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261510AbSKCAKp>; Sat, 2 Nov 2002 19:10:45 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:2062 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id <S261508AbSKCAKo> convert rfc822-to-8bit;
	Sat, 2 Nov 2002 19:10:44 -0500
From: Nero <neroz@iinet.net.au>
To: "J.A. =?iso-8859-1?q?Magall=F3n?=" <jamagallon@able.es>
Subject: Re: Kconfig (qt) -> Gconfig (gtk)
Date: Sun, 3 Nov 2002 10:16:49 +1100
User-Agent: KMail/1.4.6
References: <1036274342.16803.27.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0211030052410.13258-100000@serv> <20021103000641.GA5284@werewolf.able.es>
In-Reply-To: <20021103000641.GA5284@werewolf.able.es>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200211031016.49654.neroz@iinet.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Nov 2002 11:06 am, J.A. Magallón wrote:
> On 2002.11.03 Roman Zippel wrote:
> > Hi,
> >
> > On Sun, 3 Nov 2002, Nero wrote:
> > > OR, we could use the logical choice. GTK+ is on most systems, has
> > > hardly any dependancies, is relatively small (compared to Qt) and
> > > doesn't require a C++ compiler. Really, I think the only people being
> > > religious here are the ones voting for Qt, as it just doesn't make
> > > sense to use it for such a thing.
> >
> > Show me the source and we can continue this discussion. Right now qconf
> > is included as replacement for the old xconfig. It shouldn't take to much
> > effort to package it seperately. As soon as someone is interested in
> > doing this for a distribtion I'll add the few missing bits.
>
> As I see it, the onle thing that should be included in a standard kernel
> would be something like a kconfig-xaw, that is sure to be on every box that
> has X, and could be a reference implementation.
>
> And you could face one other religious war: qt2 or qt3 ? So as gtk1 or
> gtk2...

Gtk1 is going to be around for quite a while because so many apps wont be 
ported over to Gtk2 at all [dropped projects], and Gtk2 is not yet as 
widespread as 1.x either, so using Gtk1 is obvious. Qt2 vs. Qt3 - people tend 
to have the latest KDE if they run it, which means the latest Qt. Nearly all 
of the major distros ship with KDE3 now too (debian is still on KDE2 for some 
annoying reason, and Xandros (major?) have a hacked-to-bits KDE2).
