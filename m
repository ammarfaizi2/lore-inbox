Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267974AbUIAVlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267974AbUIAVlZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267478AbUIAVhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:37:22 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:38018 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267840AbUIAVfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 17:35:04 -0400
Subject: Re: silent semantic changes with reiser4
From: Lee Revell <rlrevell@joe-job.com>
To: Jeremy Allison <jra@samba.org>
Cc: Jamie Lokier <jamie@shareable.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Rik van Riel <riel@redhat.com>,
       Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net,
       Linus Torvalds <torvalds@osdl.org>, reiser@namesys.com, hch@lst.de,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       flx@namesys.com, reiserfs-list@namesys.com
In-Reply-To: <20040901205140.GL4455@legion.cup.hp.com>
References: <Pine.LNX.4.44.0408261011410.27909-100000@chimarrao.boston.redhat.com>
	 <200408261819.59328.vda@port.imtp.ilyichevsk.odessa.ua>
	 <1093789802.27932.41.camel@localhost.localdomain>
	 <1093804864.8723.15.camel@lade.trondhjem.org>
	 <20040829193851.GB21873@jeremy1>
	 <20040901201945.GE31934@mail.shareable.org>
	 <20040901202641.GJ4455@legion.cup.hp.com>
	 <20040901203101.GG31934@mail.shareable.org>
	 <20040901203543.GK4455@legion.cup.hp.com>
	 <20040901204746.GI31934@mail.shareable.org>
	 <20040901205140.GL4455@legion.cup.hp.com>
Content-Type: text/plain
Message-Id: <1094074502.1343.14.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 01 Sep 2004 17:35:03 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-01 at 16:51, Jeremy Allison wrote:
> On Wed, Sep 01, 2004 at 09:47:46PM +0100, Jamie Lokier wrote:
> > Jeremy Allison wrote:
> > > > I meant when I copy not using Samba.  For example, I copy the .doc
> > > > file in Windows NT to an FTP server.
> > > > 
> > > > Does the FTP operation magically linearise the .doc streams on demand?
> > > > Or does FTP lose part of the Word document?
> > > 
> > > Good question. It depends if the Microsoft ftp client is streams-aware,
> > > and understands the Microsoft OLE structured storage format and will do
> > > the linearisation on demand or not. I must confess I haven't tested this,
> > > as I don't ever run Windows other than on vmware sessions for Samba testing
> > > these days :-).
> > > 
> > > Probably a non-Microsoft ftp client would lose part of the word doc.
> > 
> > So you're saying SCP, CVS, Subversion, Bitkeeper, Apache and rsyncd
> > will _all_ lose part of a Word document when they handle it on a
> > Window box?
> > 
> > Ouch!
> 
> Yep. It's the meta data that Word stores in streams that will get lost.
> 

This is shocking.  When was this behavior introduced?

Lee

