Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266368AbTA1O3C>; Tue, 28 Jan 2003 09:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267039AbTA1O3B>; Tue, 28 Jan 2003 09:29:01 -0500
Received: from ns.suse.de ([213.95.15.193]:16910 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S266368AbTA1O27>;
	Tue, 28 Jan 2003 09:28:59 -0500
Date: Tue, 28 Jan 2003 15:38:19 +0100
From: Stefan Reinauer <stepan@suse.de>
To: Robert Morris <rob@effective-it.co.uk>
Cc: Raphael Schmid <Raphael_Schmid@CUBUS.COM>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Bootscreen
Message-ID: <20030128143818.GA31273@suse.de>
References: <20030128133252.GC23296@suse.de> <Pine.LNX.4.44.0301281336410.22665-100000@schubert.rdns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301281336410.22665-100000@schubert.rdns.com>
User-Agent: Mutt/1.4i
X-Message-Flag: Life is too short to use a crappy OS.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Robert Morris <rob@effective-it.co.uk> [030128 14:46]:
> The distribution vendors will turn it on by default - as already happened 
> with graphical bootloader screens, for example - and then the majority of 
> users will not turn it off. Then it will become the norm...
 
WRT distribution vendors, UnitedLinux, SuSE and Mandrake already come
with a bootsplash screen per default. But this is a seperate issue.

> Most Windows users notionally have the choice to download another web 
> browser such as Mozilla. But how many actually do, when Internet Explorer 
> is installed already? The consequence of this is that, de facto, IE 
> becomes the predominant browser, then web developers disregard support of 
> other browsers, and then users of Mozilla are stuck.

I think you are exaggerating with the consequences of having a
bootsplash as an _option_. 
The problem with IE is that you cannot remove it from a system, so you
have to have 2 browsers installed. With the above mentioned Linux
distributions you can, with no additional downloads from the internet,
change one config variable in /etc/sysconfig/.. and you will not get 
a bootsplash anymore, plus no memory is wasted for the pictures as well.

> Your point that everyone has a choice is correct in theory, but does not 
> take into account the very great power of influence that software 
> distributors (be they Microsoft, Red Hat, or Suse) have. 

If one of these companies wants a graphical bootsplash, they can, due to
the freedom of choice, do so. Whether or not this code ends up in the
kernel is a completely different thing and decided by the maintainers of
the several subsystems, not by any software vendor. Don't search an
enemy where there is none.

> Yes, Linux should 
> be a platform where people have a choice - but lets make the default 
> option a sensible one, and not simply copy as much of the Windows/Mac OS 
> environment as possible to try to gain favour with users of those 
> platforms, at the expense of our own user community.

I still don't get the connection between "bootsplash is bad" and
"windows has a bootsplash". 
Windows has a gui and modal dialogs, by now even a virtual filesystem 
layer. Should we get rid of that, because Microsoft uses something 
similar? No, for sure not. "Ours" is better, because everybody can
choose to use it or not, and to change it to own needs and wishes.

> The day when a default Red Hat install covers up all the startup output 
> with a pretty graphic will be a very sad one indeed for me.

Hey, maybe I can help you out with a little hint... If they ever do,
"vga=normal" will get you back to the good old times and 10 key strokes
make your day.

  Stefan

-- 
The use of COBOL cripples the mind; its teaching should, therefore, be
regarded as a criminal offense.                      -- E. W. Dijkstra
