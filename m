Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263199AbSJHVaS>; Tue, 8 Oct 2002 17:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263206AbSJHVaR>; Tue, 8 Oct 2002 17:30:17 -0400
Received: from AGrenoble-101-1-4-14.abo.wanadoo.fr ([217.128.202.14]:47058
	"EHLO awak") by vger.kernel.org with ESMTP id <S263199AbSJHVaP> convert rfc822-to-8bit;
	Tue, 8 Oct 2002 17:30:15 -0400
Subject: Re: [patch] IDE driver model update
From: Xavier Bestel <xavier.bestel@free.fr>
To: Ketil Froyn <ketil-kernel@froyn.net>
Cc: "jbradford@dial.pipex.com" <jbradford@dial.pipex.com>,
       Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "mochel@osdl.org" <mochel@osdl.org>,
       "torvalds@transmeta.com" <torvalds@transmeta.com>,
       "andre@linux-ide.org" <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40L0.0210081627480.1519-100000@ketil.np>
References: <Pine.LNX.4.40L0.0210081627480.1519-100000@ketil.np>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 
Date: 08 Oct 2002 23:34:46 +0200
Message-Id: <1034112887.4607.14.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar 08/10/2002 à 16:31, Ketil Froyn a écrit :
> On Tue, 8 Oct 2002, jbradford@dial.pipex.com wrote:
> 
> > This raises the interesting possibility of being able to refer to
> > things like removable media directly, instead of the device the media
> > is inserted in.
> >
> > The Amiga was doing this years ago.  You could access floppy drives
> > as, E.G. df0:, df1:, etc, but if you formatted a volume and called it
> > foobar, you could access foobar: no matter which floppy drive you put
> > it in to.
> 
> Isn't this possible in /etc/fstab already? Standard redhat-installs seem
> to put in the labels of the volume instead of referring to the device.

No comparison possible. The amiga dos would stall all read/write
requests when a device came offline (e.g. a floppy disk ejected) and
would cancel them all if the user or something else decided the medium
wouldn't be available anymore, and resumed everything when the medium
was online again (even if in a different device/drive).
That was a pretty sophisticated volume management if you ask me, one I
can only dream of happening one day in linux.


