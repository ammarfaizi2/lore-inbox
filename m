Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267770AbUHZU7C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267770AbUHZU7C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269659AbUHZU5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:57:04 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:61878 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269618AbUHZUiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:38:18 -0400
Subject: Re: silent semantic changes with reiser4
From: Lee Revell <rlrevell@joe-job.com>
To: Will Dyson <will_dyson@pobox.com>
Cc: Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <412E06B2.7060106@pobox.com>
References: <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de>
	 <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org>
	 <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0408251348240.17766@ppc970.osdl.org>
	 <20040825212518.GK21964@parcelfarce.linux.theplanet.co.uk>
	 <20040826001152.GB23423@mail.shareable.org>
	 <20040826003055.GO21964@parcelfarce.linux.theplanet.co.uk>
	 <20040826010049.GA24731@mail.shareable.org>
	 <20040826100530.GA20805@taniwha.stupidest.org>
	 <20040826110258.GC30449@mail.shareable.org>  <412E06B2.7060106@pobox.com>
Content-Type: text/plain
Message-Id: <1093552705.5678.96.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 16:38:26 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-26 at 11:50, Will Dyson wrote:
> Jamie Lokier wrote:
> 
> > However, as far as I know it's not accessible in a file-as-directory
> > form as yet.  In my opinion that is the most natural form and it would
> > be very intuitive to use.  I hope we can pick a useful semantics for
> > them, and also provide filesystem-independent plugins with GNU
> > Hurd-like per-user extensibility.
> > 
> > -- Jamie
> > 
> > * plenty == too much.
> >   Gnome, KDE, Emacs and Bash all see different virtual filesystems.
> >   (All but Bash implement their own virtual filesystem extensions).
> >   That makes them much less useful than they could be.
> 
> It has always bugged me that Gnome and KDE implement their own VFS layers.
> 

Same here.  This always seemed like something the kernel should be able
to handle.  It seems to me that if reiser4 had been available at the
time the Gnome and KDE developers would not have needed to do this.

Lee

