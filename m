Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266959AbTAUCJl>; Mon, 20 Jan 2003 21:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266961AbTAUCJk>; Mon, 20 Jan 2003 21:09:40 -0500
Received: from harddata.com ([216.123.194.198]:659 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id <S266959AbTAUCJk>;
	Mon, 20 Jan 2003 21:09:40 -0500
Date: Mon, 20 Jan 2003 19:18:38 -0700
From: Michal Jaegermann <michal@harddata.com>
To: John Levon <levon@movementarian.org>, linux-kernel@vger.kernel.org,
       Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: [2.5] initrd/mkinitrd still not working
Message-ID: <20030120191838.A7174@mail.harddata.com>
References: <200301201457.PAA25276@harpo.it.uu.se> <20030120155250.GB58326@compsoc.man.ac.uk> <20030120191250.GA1314@mars.ravnborg.org> <20030120191921.GA84425@compsoc.man.ac.uk> <20030120193546.GC1314@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030120193546.GC1314@mars.ravnborg.org>; from sam@ravnborg.org on Mon, Jan 20, 2003 at 08:35:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2003 at 08:35:46PM +0100, Sam Ravnborg wrote:
> On Mon, Jan 20, 2003 at 07:19:21PM +0000, John Levon wrote:
> > Ooops, I was mis-remembering commit logs. I meant :
> > 
> > http://linus.bkbits.net:8080/linux-2.5/user=kai/cset@1.838.1.86?nav=!-|index.html|stats|!+|index.html|ChangeSet
> 
> OK, this is something else.
> Making the shift to the extension .ko allowed the syntax:
> make fs/ext2/ext2.ko or whatever module we want to build.
> 
> Thats very nice when developing on a module to speed up things.

Well, yes, but while installing into a final location all these .ko
files could be renamed to have .o extensions.  This would avoid
screwing up user-space utilities.  It is not that difficult to
fix mkinitrd to try _both_ ways (I do not know how many folks runs
exclusively 2.5 kernels) but who knows how many other things
will have to be modified introducing gratituos incompatibilities.

   Michal
