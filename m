Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267510AbUH1SaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267510AbUH1SaI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 14:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267507AbUH1SaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 14:30:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24205 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267494AbUH1SaE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 14:30:04 -0400
Date: Sat, 28 Aug 2004 19:29:54 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, Rik van Riel <riel@redhat.com>,
       Spam <spam@tnonline.net>, Jamie Lokier <jamie@shareable.org>,
       Hans Reiser <reiser@namesys.com>, David Masover <ninja@slaphack.com>,
       Diego Calleja <diegocg@teleline.es>, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       hch@lst.de, linux-fsdevel@vger.kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040828182954.GJ21964@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0408272158560.10272-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0408271902410.14196@ppc970.osdl.org> <20040828170515.GB24868@hh.idb.hist.no> <Pine.LNX.4.58.0408281038510.2295@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408281038510.2295@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 11:09:38AM -0700, Linus Torvalds wrote:
> Comments? Does anybody hate "openat()" for any reason (regardless of 
> attributes)? We can easily support it, we'd just need to pass in the file 
> to use as part of the "nameidata" thing or add an argument (it would also 
> possibly be cleaner if we made "fs->pwd" be a "struct file").

What would your openat() produce?  Normal struct file?  Then what's going
to be its vfsmount/dentry and what will they be attached to?
