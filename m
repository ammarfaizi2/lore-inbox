Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267612AbUIFIGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267612AbUIFIGt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 04:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267624AbUIFIGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 04:06:48 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:424 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S267612AbUIFIFq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 04:05:46 -0400
Date: Mon, 6 Sep 2004 10:05:34 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <1873133500.20040906100534@tnonline.net>
To: Tonnerre <tonnerre@thundrix.ch>
CC: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@lst.de>, <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
In-Reply-To: <20040906074518.GA28697@thundrix.ch>
References: <20040826150202.GE5733@mail.shareable.org>
 <200408282314.i7SNErYv003270@localhost.localdomain>
 <20040901200806.GC31934@mail.shareable.org>
 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
 <1094118362.4847.23.camel@localhost.localdomain>
 <Pine.LNX.4.58.0409021045210.2295@ppc970.osdl.org>
 <1591214030.20040902215031@tnonline.net> <20040906074518.GA28697@thundrix.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> Salut,

> On Thu, Sep 02, 2004 at 09:50:31PM +0200, Spam wrote:
>> Their  libraries are  huge and  memory hogging  which so  many Linux
>> users just do not like.

> This  is rather  a  fud argument:  both  the gnome  VFS  code and the
> KIOserver/KIOslave  code aren't really  large. You  don't want  to use
> them for a busybox/tinylogin system, however.

  Then it is good. Just I see no programs other than Gnome or KDE apps
  that are using them.

>> What if  a user doesn't want  KDE or Gnome? Would  all files created
>> with either be broken?

> The files  still work well, just  that you can't access  them over the
> old fancy URL schemes.

  No only, but if you cp then with a non KDE/Gnome app then you will
  loose the meta-data and extra info too. That was my point.

>> I  doubt  that  something   like  file  streams  and  meta-data can
>> successfully be  implemented purely in  user-space and get  the same
>> support (ie  be used by many  programs) if this  change doesn't come
>> from the kernel. I just do not see it happen.

> Actually,  practical  discordianism.  If  you develop  a  common  API,
> there'll always be people disagreeing.

> GTK+ with all  its features is just cool. Desktop  warping is a really
> nice  thing. But  there are  people out  there who  don't want  to use
> it. They use QT, or even plain old Athena Widgets. So what? Will we be
> implementing the X toolkits into the kernel?

  This is certainly not what I said or wanted.

> In case of marketing it's up to the distributions to provide something
> concise  so  everyone  can  use  their  programs  through  a  coherent
> namespace. (I.e. port all the apps they ship to gnome-vfs or kio).

  Do you really believe this will happen? Good if it did. I do not
  believe it. And I certainly do not see the thousands of man hours
  needed to actually provide all the patches as a benefit.

  ~S

> 			    Tonnerre

