Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266572AbUIEM2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266572AbUIEM2b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 08:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266566AbUIEM2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 08:28:31 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:3474 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S266572AbUIEM1v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 08:27:51 -0400
Date: Sun, 5 Sep 2004 14:27:39 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <285406007.20040905142739@tnonline.net>
To: Tonnerre <tonnerre@thundrix.ch>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Lee Revell <rlrevell@joe-job.com>,
       Pavel Machek <pavel@ucw.cz>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jamie Lokier <jamie@shareable.org>, David Masover <ninja@slaphack.com>,
       Chris Wedgwood <cw@f00f.org>, <viro@parcelfarce.linux.theplanet.co.uk>,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040905120758.GI26560@thundrix.ch>
References: <rlrevell@joe-job.com> <1094079071.1343.25.camel@krustophenia.net>
 <200409021425.i82EPn9i005192@laptop11.inf.utfsm.cl>
 <1535878866.20040902214144@tnonline.net>
 <20040902194909.GA8653@atrey.karlin.mff.cuni.cz>
 <1094155277.11364.92.camel@krustophenia.net>
 <1094152590.5726.37.camel@localhost.localdomain>
 <20040905120758.GI26560@thundrix.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> Salut,

> On Thu, Sep 02, 2004 at 08:16:35PM +0100, Alan Cox wrote:
>> Thats how you get yourself a non useful OS. Fix it in a library and
>> share it between the apps that care. Like say.. gnome-vfs2

> Even KIOslave has  it. They even support sftp and  stuff just by using
> shared files  in /tmp in reality.  That's a much  saner interface than
> doing it all in the kernel.

> I  mean,  the  kernel  is  supposed  to support  access  to  the  disk
> drives. Who says that it's got  to be the uppermost VFS level? You can
> be perfectly happy to build your own  VFS on top of it (or use other's
> implementations, that is.)

  Yes, we have several VFS versions. KDE and Gnome has their own, mc
  another, and so on. None is compatible with the other and all data
  is unavailable if you do not use a program specifically coded to use
  the particular VFS you stored the data with.

> I can  already see people moving  to FreeBSD if  this gets implemented
> into the kernel...

  Why? No one has to use it. you do not have to load FS/VFS plugins so
  you can extend the functionality of your filesystem with stuff like
  compression, encryption, sorting, filtering, etc etc..

  

> 			    Tonnerre

