Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267953AbUIAWwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267953AbUIAWwr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 18:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267708AbUIAWwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 18:52:30 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:16777 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267681AbUIAWvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 18:51:13 -0400
Subject: Re: silent semantic changes with reiser4
From: Lee Revell <rlrevell@joe-job.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Pavel Machek <pavel@suse.cz>, David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <20040901215939.GK31934@mail.shareable.org>
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl>
	 <41352279.7020307@slaphack.com> <20040901045922.GA512@elf.ucw.cz>
	 <20040901161456.GA31934@mail.shareable.org>
	 <20040901201824.GB11838@atrey.karlin.mff.cuni.cz>
	 <20040901215939.GK31934@mail.shareable.org>
Content-Type: text/plain
Message-Id: <1094079071.1343.25.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 01 Sep 2004 18:51:12 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-01 at 17:59, Jamie Lokier wrote:
> Pavel Machek wrote:
> > > Can I do these already using uservfs?
> > > 
> > >    cd
> > >    less foo.zip/contents/bar.c
> > 
> > less foo.zip#uzip/contents/bar.c
> > 
> > >    less /usr/portage/distfiles/perl-5.8.5.tar.gz/contents/toke.c
> > 
> > less /usr/portage/distfiles/perl-5.8.5.tar.gz#utar/contents/toke.c
> >
> > >    grep -R obscure_label ~/RPMS
> > 
> > I do not think you'd want this. How would you tell grep obscure label
> > without entering archives, then? 
> 
> Granted, this is where we need "grep --recurse-into-files" or, more
> generally useful, a find option.
> 

FWIW, this is how Windows does it now.  As of XP, 'Find files' has an
option, enabled by default, to look inside archives.  If you tell it to
look for a driver in a given directory it will also look inside .cab 
and .zip files.  It's extremely useful, I would imagine someone who uses
XP a lot will come to expect this feature.

Of course, no idea how it's implemented, but users like it.

Lee

