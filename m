Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266736AbTATT0o>; Mon, 20 Jan 2003 14:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266749AbTATT0o>; Mon, 20 Jan 2003 14:26:44 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:14088 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S266736AbTATT0n>;
	Mon, 20 Jan 2003 14:26:43 -0500
Date: Mon, 20 Jan 2003 20:35:46 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: John Levon <levon@movementarian.org>
Cc: linux-kernel@vger.kernel.org, Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: [2.5] initrd/mkinitrd still not working
Message-ID: <20030120193546.GC1314@mars.ravnborg.org>
Mail-Followup-To: John Levon <levon@movementarian.org>,
	linux-kernel@vger.kernel.org, Mikael Pettersson <mikpe@csd.uu.se>
References: <200301201457.PAA25276@harpo.it.uu.se> <20030120155250.GB58326@compsoc.man.ac.uk> <20030120191250.GA1314@mars.ravnborg.org> <20030120191921.GA84425@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030120191921.GA84425@compsoc.man.ac.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2003 at 07:19:21PM +0000, John Levon wrote:
> Ooops, I was mis-remembering commit logs. I meant :
> 
> http://linus.bkbits.net:8080/linux-2.5/user=kai/cset@1.838.1.86?nav=!-|index.html|stats|!+|index.html|ChangeSet

OK, this is something else.
Making the shift to the extension .ko allowed the syntax:
make fs/ext2/ext2.ko or whatever module we want to build.

Thats very nice when developing on a module to speed up things.

As of today you can actually do:

make fs/ext2/file.o
make fs/ext2/file.lst
make fs/ext2/file.s
make fs/ext2/file.i

and the above mentioned with a .ko module.

There is also the possibility to do:
make SUBDIRS=fs/ext2

and I hope that the following syntax will be anabled as well:
make fs/ext2/

[Patch queued for submission]

	Sam
