Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288377AbSCEWHx>; Tue, 5 Mar 2002 17:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291041AbSCEWHf>; Tue, 5 Mar 2002 17:07:35 -0500
Received: from chaos.analogic.com ([204.178.40.224]:38272 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S288377AbSCEWHY>; Tue, 5 Mar 2002 17:07:24 -0500
Date: Tue, 5 Mar 2002 17:07:12 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Pavel Machek <pavel@suse.cz>
cc: Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
In-Reply-To: <20020304162614.C96@toy.ucw.cz>
Message-ID: <Pine.LNX.3.95.1020305165859.27211A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2002, Pavel Machek wrote:

> Hi
> > > All the deleted files, with the correct path(s), are now in the
> > > top directory file the file-system ../lost+found directory. They
> > > are still owned by the original user, still subject to the same
> > > quota.
> > 
> > And what about:
> > 
> > - Luser rm's "foo.c"
> > - Luser starts working on new version of "foo.c"
> > - Luser recognizes, that the old version was better
> > - Luser rm's new "foo.c"
> > - Luser tries to unrm the old "foo.c" -> *bang*
> > 
> > Trust me, there /will/ be a luser who tries to do it this way. If
> > teaching lusers were enough, you'd have no need for an unrm at all.
> 
> You don't consider me a luser, right?

Nope.

Some newbees think that Windoze 'send-to-the-wastebasket' is a kernel-
level "safe-delete". It's just some ^&$)##*@*) program that slows most
of us down.

Even Windows/Professional/2000 (NT) developers knew that it was
garbage. If you've figured out how to get to the CMD prompt, just
type:

cd \
rm -r *.*
 |  |   |______ They still have dots
 |  |__________ Yes, even "folders" <coff, coff>
 |_____________ What do you expect for a stolen OS? Yes, `rm` instead of
                del, following the Unix pathname tradition.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (799.53 BogoMips).

	Bill Gates? Who?

