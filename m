Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266485AbUIANMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266485AbUIANMy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 09:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266473AbUIANMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 09:12:53 -0400
Received: from the-village.bc.nu ([81.2.110.252]:7051 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266467AbUIANMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 09:12:45 -0400
Subject: Re: silent semantic changes with reiser4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@ucw.cz>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <Pine.LNX.4.58.0408311252150.2295@ppc970.osdl.org>
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl>
	 <Pine.LNX.4.58.0408311252150.2295@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094040615.2474.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 01 Sep 2004 13:10:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-31 at 21:05, Linus Torvalds wrote:
> In a graphical environment, the "icon" stream is a good example of this.  
> It literally has _nothing_ to do with the data in the main stream. The
> only linkage is a totally non-technical one, where the user wanted to
> associate a secondary stream with the main stream _without_ altering the
> main one. THAT is where named streams make sense.

The icon doesn't belong in the document, that was a catastrophic
disaster in early MacOS (although they only use an index). Users want to
manage their icon choices, tags, tooltip notes and attached labels, and
you cannot do that in the file if you don't own the file. 

Also the icon is *not* unrelated to the file in a modern GUI, eg rox and
nautilus uses scaled versions of the content for many media types and
will show you pictures, frames from a movie etc to help you remember the
content. On top they then add user specific annotations.

The things that are more independant are:

"This file was created by OpenOffice 1.2"
"This is a text/plain file in UTF-8"
"This file has a UUID of ...."

The type has dragons because you get heirarchical typing within
documents (consider XML containing namespaces)

(UUIDs being one really useful thing we don't tag everywhere onto files
that would be a godsend on the desktop providing they moved with the
file on rename)

Alan

