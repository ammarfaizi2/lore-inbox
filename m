Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269249AbUHaXGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269249AbUHaXGS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 19:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269186AbUHaXDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 19:03:16 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:20905 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S268675AbUHaXCZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 19:02:25 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@ucw.cz>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl>
	<Pine.LNX.4.58.0408311252150.2295@ppc970.osdl.org>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 01 Sep 2004 01:02:24 +0200
In-Reply-To: <Pine.LNX.4.58.0408311252150.2295@ppc970.osdl.org>
Message-ID: <m3eklm9ain.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> In a graphical environment, the "icon" stream is a good example of this.  
> It literally has _nothing_ to do with the data in the main stream. The
> only linkage is a totally non-technical one, where the user wanted to
> associate a secondary stream with the main stream _without_ altering the
> main one. THAT is where named streams make sense.

I think that the "icon" argument for named streams is a silly
argument, since different users may want to have different icons for
the same file.  Say that I want /usr/bin/emacs to have the enterprise
icon and someone else wants the gnu head icon.  And besides, root owns
the file anyways, so neither of us mortal users should be able to add
a stream to it.

Another reason for named streams that usually crops up is the ability
set a "preferred application" for a certain file, so that when I
double click on a document I want to open it with antiword instead of
openoffice.  But the same contra-argument applies here, different
users have different preferences.

I can see the argument for having the equivalent of Content-type or
Content-transfer-encoding as a named stream though.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
