Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268049AbUIHOIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268049AbUIHOIy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 10:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267856AbUIHOHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 10:07:40 -0400
Received: from the-village.bc.nu ([81.2.110.252]:1192 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268049AbUIHOC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 10:02:57 -0400
Subject: Re: silent semantic changes with reiser4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tonnerre <tonnerre@thundrix.ch>
Cc: Pavel Machek <pavel@ucw.cz>, Christer Weinigel <christer@weinigel.se>,
       Spam <spam@tnonline.net>, Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <20040908061159.GC1630@thundrix.ch>
References: <20040905111743.GC26560@thundrix.ch>
	 <1215700165.20040905135749@tnonline.net>
	 <20040905115854.GH26560@thundrix.ch>
	 <1819110960.20040905143012@tnonline.net>
	 <20040906105018.GB28111@atrey.karlin.mff.cuni.cz>
	 <6010544610.20040906143222@tnonline.net> <m3wtz7h2l6.fsf@zoo.weinigel.se>
	 <826067315.20040906171320@tnonline.net> <m3sm9vh06b.fsf@zoo.weinigel.se>
	 <20040906155456.GC13539@atrey.karlin.mff.cuni.cz>
	 <20040908061159.GC1630@thundrix.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094648265.11680.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 08 Sep 2004 13:57:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-08 at 07:11, Tonnerre wrote:
> This  has   been  discussed  along   with  the  HAL  people   a  while
> ago. Actually, file systems can  introduce a refcount, where we need a
> decrement function  which automatically unmounts the  filesystem if we
> decrement the use count to zero. Kind of an automatic umount.

We've supported file system garbage collection when they become unused
since umm about 2.4.10 I think.

