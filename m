Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267646AbUIFILc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267646AbUIFILc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 04:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267645AbUIFILX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 04:11:23 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:55192 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S267614AbUIFIIq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 04:08:46 -0400
Date: Mon, 6 Sep 2004 10:08:45 +0200
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: Tonnerre <tonnerre@thundrix.ch>
Cc: Frank van Maarseveen <frankvm@xs4all.nl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
Message-ID: <20040906080845.GA31483@janus>
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <1094118362.4847.23.camel@localhost.localdomain> <20040902203854.GA4801@janus> <20040906075603.GB28697@thundrix.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040906075603.GB28697@thundrix.ch>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2004 at 09:56:03AM +0200, Tonnerre wrote:
> 
> $ cat fs_header owner_root flags_with_suid evil_program > evil.iso
> $ ls -l evil.iso/evil_program

It should of course be equivalent to a user mount: nodev nosuid etc.

-- 
Frank
