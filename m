Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266547AbUIEMXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266547AbUIEMXp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 08:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266555AbUIEMXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 08:23:45 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:52369 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S266547AbUIEMXk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 08:23:40 -0400
Date: Sun, 5 Sep 2004 14:23:23 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <1715434586.20040905142323@tnonline.net>
To: Tonnerre <tonnerre@thundrix.ch>
CC: Christer Weinigel <christer@weinigel.se>,
       Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@ucw.cz>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040905115854.GH26560@thundrix.ch>
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl>
 <Pine.LNX.4.58.0408311252150.2295@ppc970.osdl.org>
 <m3eklm9ain.fsf@zoo.weinigel.se> <20040905111743.GC26560@thundrix.ch>
 <1215700165.20040905135749@tnonline.net> <20040905115854.GH26560@thundrix.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> Salut,

> On Sun, Sep 05, 2004 at 01:57:49PM +0200, Spam wrote:
>>   What if I do not use emacs, but vim, mcedit, gedit, or some other
>>   editor? It doesn't seem logical to have to patch every application
>>   that uses files.

> We would have to do that in  either case, so let's patch them to do it
> in a nonintrusive way. And as to reading and writing inside tar files,
> write and/or  use a really nice  userspace library to do  it. (As does
> MacOS/X, as does KDE, etc.)

  No, not with the current setup with file-as-dir. It also works in
  Gnome/Natilus. Just tested:

  mkdir test
  chmod +x test
  cd test
  dir metas
  echo 0777>rwx

  In Nautilus I just typed in in the address bar /test/metas/
  I could open meta-data and change with GEdit too.

  I do not see that I have had to patch any programs to get this to
  work.

  ~S

> 			    Tonnerre

