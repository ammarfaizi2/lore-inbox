Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269043AbUH0IvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269043AbUH0IvX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 04:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269174AbUH0IvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 04:51:23 -0400
Received: from verein.lst.de ([213.95.11.210]:3821 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S269043AbUH0IvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 04:51:11 -0400
Date: Fri, 27 Aug 2004 10:49:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: Spam <spam@tnonline.net>, Wichert Akkerman <wichert@wiggy.net>,
       Christer Weinigel <christer@weinigel.se>, Andrew Morton <akpm@osdl.org>,
       jra@samba.org, torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040827084910.GA21968@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Bernd Petrovitsch <bernd@firmix.at>, Spam <spam@tnonline.net>,
	Wichert Akkerman <wichert@wiggy.net>,
	Christer Weinigel <christer@weinigel.se>,
	Andrew Morton <akpm@osdl.org>, jra@samba.org, torvalds@osdl.org,
	reiser@namesys.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, flx@namesys.com,
	reiserfs-list@namesys.com
References: <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1939276887.20040826114028@tnonline.net> <20040826024956.08b66b46.akpm@osdl.org> <839984491.20040826122025@tnonline.net> <m3llg2m9o0.fsf@zoo.weinigel.se> <1906433242.20040826133511@tnonline.net> <20040826113332.GL2612@wiggy.net> <1211039639.20040826134354@tnonline.net> <1093592467.18603.6.camel@tara.firmix.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093592467.18603.6.camel@tara.firmix.at>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 09:41:07AM +0200, Bernd Petrovitsch wrote:
> > > UNIX doesn't have a copy systemcall, applications copy the data
> > > manually.
> > 
> >   Oh, this is very unfortunate and should be a bigger issue to fix.
> 
> Then you have to rewrite POSIX und SuSv3.

They don't say 'you must now have a copy syscall'.  Having one that's
actually used by system tools would be a great optimization for many
network or distributed filesystems.

