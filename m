Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267661AbUIDLHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267661AbUIDLHr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 07:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269880AbUIDLHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 07:07:47 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:51338 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S267661AbUIDLHj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 07:07:39 -0400
Date: Sat, 4 Sep 2004 13:07:25 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <1166882144.20040904130725@tnonline.net>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Dave Kleikamp <shaggy@austin.ibm.com>, Paul Jakma <paul@clubi.ie>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jamie Lokier <jamie@shareable.org>,
       Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@lst.de>, fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
In-Reply-To: <200409032145.i83LjdXG002843@localhost.localdomain>
References: Message from Spam <spam@tnonline.net>    of "Fri, 03 Sep 2004
 15:16:19 +0200." <642078516.20040903151619@tnonline.net>
 <200409032145.i83LjdXG002843@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> Spam <spam@tnonline.net> said:
>> Dave Kleikamp <shaggy@austin.ibm.com> said:
>> >Spam <spam@tnonline.net> said:

> [...]

>> > You're missing the point.  We don't need transparency in all apps.  You
>> > can write an application to be as transparent as you want, but you don't
>> > need every app to to understand every file format.

>>   No, but not every user "can write an application" either, or even
>>   have the skills to apply patches. What I was talking about wasn't
>>   just tar, which itself isn't the best example anyway, but the idea
>>   that users can load plugins that will extend the functionality of
>>   their filesystems. That idea seem to be to be _much_ better than
>>   trying to teach every user how to write applications or patch
>>   existing ones.

> Why compare "write application or apply patches" to "load plugin"? It
> would be locical to compare running applications with loading plugins (and
> even so, loading plugins is presumably root-only).

  Doesn't matter if it is root-only. Ask the admin about the specific
  plugin the user wants. For most other users they can su to root and
  do this on their own computers. Not everyone is using Linux is a
  corporate world.

> [...]

>> > There are userland tools that deal with hundreds of file formats. Use
>> > the tool you need, rather than try to have the kernel do everything.

>>   No, but if I wanted to have an encryption plugin active for some of
>>   my files or directories then why should I not be able to? I still
>>   want to edit, view and save my encrypted files.

> Use an editor that knows about encrypted files. Decrypt/edit/encrypt if no
> other option (I'm sure emacs can be coerced to do that transparently ;-). I
> for one would be _way_ more confortable with my users doing that than them
> loading random modules into the kernel. Besides, if one of my users doesn't
> trust the system encryption programs, and prefers hers, she can be happy.

  That just doesn't do it. I doubt there will be an option to save
  encrypted Word and Excel files and be able to open them in Abiword,
  StarOffice or OpenOffice unless the decryption/encryption is done on
  a lower level.

  Also, eventually there may be a userland interface for loading
  certain modules without root access.?

>>   Again, this was just an example of what could be done with plugins.
>>   It is not said that every conceivable plugin will be written, nor
>>   loaded per default. Even though plugins cannot today be dynamically
>>   used, they will be eventually. Reiser4 is still very young.

> Modules of the kernel were supposed to have all those magic properties too,
> until there were nasty races... and it was _seriously_ considered to take
> them out. They stayed because they are root-only business, and (un)loading
> is rare. FS plugins are kernel modules, AFAIU, and are subject to the same
> problems.

>>   Please separate your thoughts for specific plugins from those of the
>>   idea to have plugins at all.

> If you can't find concrete uses for specific plugins, they are the
> proverbial solution searching for a problem.

  To me there are fine and good uses for plugins. Everyone seem to
  think different though.

  Sure many things can perhaps be done by linking and piping lots of
  programs, just to access some data. But that certainly is far from
  user friendly.

  ~S


