Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267860AbUIGLsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267860AbUIGLsW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 07:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267891AbUIGLsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 07:48:22 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:1510 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S267860AbUIGLsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 07:48:02 -0400
Date: Tue, 7 Sep 2004 13:48:00 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Oliver Hunt <oliverhunt@gmail.com>
Cc: Jeremy Allison <jra@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040907114800.GA18444@MAIL.13thfloor.at>
Mail-Followup-To: Oliver Hunt <oliverhunt@gmail.com>,
	Jeremy Allison <jra@samba.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	reiserfs-list@namesys.com
References: <1093789802.27932.41.camel@localhost.localdomain> <1093804864.8723.15.camel@lade.trondhjem.org> <20040829193851.GB21873@jeremy1> <20040901201945.GE31934@mail.shareable.org> <20040901202641.GJ4455@legion.cup.hp.com> <20040901203101.GG31934@mail.shareable.org> <20040901203543.GK4455@legion.cup.hp.com> <20040901204746.GI31934@mail.shareable.org> <20040901205140.GL4455@legion.cup.hp.com> <4699bb7b04090116227ad1e7c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4699bb7b04090116227ad1e7c0@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 11:22:41AM +1200, Oliver Hunt wrote:
> The loss of forks in the file is exxactly the problem you used to have
> when transferring native Mac files to a PC...
> 
> This meant in order to transfer files to different filesystem you
> often needed to tar/zip/whatever them first.
> 
> Bare in mind this would let us do the whole MacOS thing of putting an
> entire application(plus plugins, etc) inside one "file"...

hum, well aside from the fact that recent MacOS (X) does
not put applications in one "file", it does simply store
related stuff inside a directory which is presented as
one unit by the GUI ... something I consider useful and
which allows to 'move' the application around without
rendering them useless ...

best,
Herbert

> --Oliver
> 
> On Wed, 1 Sep 2004 13:51:40 -0700, Jeremy Allison <jra@samba.org> wrote:
> > On Wed, Sep 01, 2004 at 09:47:46PM +0100, Jamie Lokier wrote:
> > > Jeremy Allison wrote:
> > > > > I meant when I copy not using Samba.  For example, I copy the .doc
> > > > > file in Windows NT to an FTP server.
> > > > >
> > > > > Does the FTP operation magically linearise the .doc streams on demand?
> > > > > Or does FTP lose part of the Word document?
> > > >
> > > > Good question. It depends if the Microsoft ftp client is streams-aware,
> > > > and understands the Microsoft OLE structured storage format and will do
> > > > the linearisation on demand or not. I must confess I haven't tested this,
> > > > as I don't ever run Windows other than on vmware sessions for Samba testing
> > > > these days :-).
> > > >
> > > > Probably a non-Microsoft ftp client would lose part of the word doc.
> > > 
> > > So you're saying SCP, CVS, Subversion, Bitkeeper, Apache and rsyncd
> > > will _all_ lose part of a Word document when they handle it on a
> > > Window box?
> > >
> > > Ouch!
> > 
> > Yep. It's the meta data that Word stores in streams that will get lost.
> > 
> > 
> > 
> > Jeremy.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
