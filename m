Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265074AbTANTKm>; Tue, 14 Jan 2003 14:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265081AbTANTKm>; Tue, 14 Jan 2003 14:10:42 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:19965 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S265074AbTANTKk>; Tue, 14 Jan 2003 14:10:40 -0500
Date: Mon, 14 Jan 2002 20:18:15 +0100
From: Romain Lievin <roms@tilp.info>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why the new config process is a *big* step backwards
Message-ID: <20020114191815.GA347@wanadoo.fr>
References: <Pine.LNX.4.44.0301130743100.25468-100000@dell> <3E23390F.29FF27D3@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E23390F.29FF27D3@linux-m68k.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 11:09:19PM +0100, Roman Zippel wrote:
> Hi,
> 
> >   at least in the old "make xconfig", i could bring up two
> > children dialogs at a time.  perhaps i want to examine/configure
> > both "Block devices" and "Filesystems" at the same time, since
> > there are some related features (loopback device support under
> > Block devices lets me mount filesystem images).  under the
> > new scheme, this is impossible (unless there's a trick or
> > feature i haven't found).
> 
> Have you found the full tree mode?
> I'm thinking about the option to open a submbenu in its own window, but
> it will not be the default. I really hate it when a program thinks it
> has to open a new window for everything.

Well, popup dialogs are very annoying...
The current system has enough windows for dislaying the important informations
(hierarchy, help, informations).

> 
> >   and that option window is just confusing.  given that we
> > already have +/- expand/collapse icons, and checkboxes for
> > selection, it just makes things messier to have these submenu
> > boxes with the internal triangle.  and once it takes you to
> > that submenu, is it really painfully obvious how you back up
> > one level?  (the arrow icon in the tool bar?)
> 
> Offering too many options at once is not good either, as then you have
> the choice that you must expand lots of submenus until you find, what
> you need or you have a huge list of options. The current window is a
> compromise, which doesn't show too much and already has everything
> expanded. If possible I would omit the +/- icons, but it's not possible
> without reimplementing the whole widget.

To my mind, the current configuration system provides enough options (ie views)
for most of the users without having a program too complex/big...
Moreover, I think that the Split & Tree views are very practictal.

The +/- icons (even if they are not available in the GTK+ version) allow you
to change an option without displaying the other columns.
It may be very useful if you have a small screen size. You don't have to scroll
the window...

> 
> bye, Roman
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Romain.
-- 
Romain Lievin, aka 'roms'  	<roms@tilp.info>
The TiLP project is on 		<http://www.ti-lpg.org>
"Linux, y'a moins bien mais c'est plus cher !"














