Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265172AbSJaDoK>; Wed, 30 Oct 2002 22:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265173AbSJaDoJ>; Wed, 30 Oct 2002 22:44:09 -0500
Received: from web1.elbnet.com ([65.209.12.165]:16568 "EHLO web1.elbnet.com")
	by vger.kernel.org with ESMTP id <S265172AbSJaDoJ>;
	Wed, 30 Oct 2002 22:44:09 -0500
Date: Wed, 30 Oct 2002 22:36:39 -0500
From: Bob Billson <reb@bhive.dhs.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lkc 1.2: make xmenu error
Message-ID: <20021031033639.GA6386@etain.bhive.dhs.org>
References: <20021030223843.GF4186@etain.bhive.dhs.org> <Pine.LNX.4.44.0210302355150.13257-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0210302355150.13257-100000@serv>
User-Agent: Mutt/1.4i
Organization: Hopeless... my honeybees are more organized.
X-Moon: The Moon is Waning Crescent (29% of Full)
X-Uptime: 22:24:48 up 1 day,  7:15,  4 users,  load average: 1.89, 1.81, 1.64
X-GPG-Key: http://bhive.dhs.org/gpgkey.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 11:58:46PM +0100, Roman Zippel penned:
> > This is on a Debian (testing tree) box with the libqt3-dev package
> > installed.  moc is there, just not in /usr/share/qt/bin:
> > 
> > [reb@etain]:~/kernel/linux-2.5.44$ whereis moc
> > moc: /usr/bin/moc /usr/share/man/man1/moc.1.gz
> 
> Debian creates symlinks in /usr/share/qt/bin, which point to /usr/bin, so 
> this should work (at least it does here :) ). How does your 
> /usr/share/qt/bin look like?

Doh!  There were no symlinks.  I reinstalled the package and magically
they appeared.   So ...umm... never mind that bug report. :)

     thanks... bob
-- 
 bob billson        email: reb@bhive.dhs.org          ham: kc2wz    /)
                           reb@elbnet.com             beekeeper  -8|||}
 "Níl aon tinteán mar do thinteán féin." --Dorothy    Linux geek    \)
 [ GPG key: http://bhive.dhs.org/gpgkey.html ]
