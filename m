Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267520AbUH1S4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267520AbUH1S4R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 14:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267535AbUH1S4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 14:56:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32654 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267520AbUH1S4P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 14:56:15 -0400
Date: Sat, 28 Aug 2004 19:56:13 +0100
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
Message-ID: <20040828185613.GK21964@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0408272158560.10272-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0408271902410.14196@ppc970.osdl.org> <20040828170515.GB24868@hh.idb.hist.no> <Pine.LNX.4.58.0408281038510.2295@ppc970.osdl.org> <20040828182954.GJ21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408281132480.2295@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408281132480.2295@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 11:44:52AM -0700, Linus Torvalds wrote:
> Going back to O_XATTR: that would end up doing the "special vfsmount"  
> magic at the beginning of the lookup. If the dentry you started with
> wasn't marked D_HYBRID, it would just return -ENOTDIR.

OK, let me restate the question - what do we get from pwd if we do
fchdir() to such beast?
