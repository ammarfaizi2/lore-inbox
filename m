Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268210AbUIFPzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268210AbUIFPzr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 11:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268189AbUIFPze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 11:55:34 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21985 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268174AbUIFPy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 11:54:57 -0400
Date: Mon, 6 Sep 2004 17:54:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christer Weinigel <christer@weinigel.se>
Cc: Spam <spam@tnonline.net>, Tonnerre <tonnerre@thundrix.ch>,
       Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040906155456.GC13539@atrey.karlin.mff.cuni.cz>
References: <m3eklm9ain.fsf@zoo.weinigel.se> <20040905111743.GC26560@thundrix.ch> <1215700165.20040905135749@tnonline.net> <20040905115854.GH26560@thundrix.ch> <1819110960.20040905143012@tnonline.net> <20040906105018.GB28111@atrey.karlin.mff.cuni.cz> <6010544610.20040906143222@tnonline.net> <m3wtz7h2l6.fsf@zoo.weinigel.se> <826067315.20040906171320@tnonline.net> <m3sm9vh06b.fsf@zoo.weinigel.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3sm9vh06b.fsf@zoo.weinigel.se>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Sure, we could say that we add another level of indirection to the
> named streams, so that we specify the driver as the first component of
> te magic file-as-directory, i.e. foo.tar.gz/ungzipped would refer to
> the ungzipped stream and foo.tar.gz/ungzipped-and-untarred would show
> the tar file as a directory, but really, this isn't any more useful
> than doing a userfs mount.  The userfs mount does not break existing
> semantics (anymore than mount -o loop does today), and it will work
> with the existing infrastructure in the linux kernel.  The only
> advantage of files-as-directories with magic plugins in the kernel is
> that one can look at it and say "look, how neat, the filenames look
> almost the same".

Who is going to umount it when application crashes, etc? Plus mount
required root priviledges last time I checked.

								Pavel

