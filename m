Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267953AbUH2O2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267953AbUH2O2o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 10:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267936AbUH2O2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 10:28:22 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:32683 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S267923AbUH2O2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 10:28:07 -0400
Message-Id: <200408272358.i7RNweGh002703@localhost.localdomain>
To: Spam <spam@tnonline.net>
cc: Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4 
In-Reply-To: Message from Spam <spam@tnonline.net> 
   of "Thu, 26 Aug 2004 13:15:47 +0200." <1453776111.20040826131547@tnonline.net> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Fri, 27 Aug 2004 19:58:40 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spam <spam@tnonline.net> said:
> Andrew Morton <akpm@osdl.org> said:

[...]

> > For example, some image file formats already support embedded metadata, do
> > they not?

>   Yes, JPEG, TIFF and PNG files for example. But, if you modify any of
>   these  with  an application that doesn't support the extensions then
>   you will loose them.

As you will each time you muck around with your files-are-directories.
Nothing new there.

>   Also,  you  are thinking _very_ narrowly now. There are thousands of
>   file  formats.  Implementing  the  support  for  meta-data/ streams/
>   attributes  in  the  kernel  will  make  it  possible  to  use  this
>   generically for all files.

So the _kernel_ has to know about thousands of formats, just in case it
some blue day it comes across a strange file? Better leave that to the
applications.

You will _not_ be able to define a single format for extra data about the
file, there will be differing extra data for different users (do you
suggest a root-only file with special writable pouches for "graphical icon
for the file" for each user on the system?!), so the idea in itself is
doomed from the start.

>   I  use  this  in  Windows  quite much.

Then use it and be happy. No need to screw up Linux for that.

>                                          I put information description
>   fields  for  lots  of  different  files. These descriptions are then
>   searchable etc. I could use the command prompt to copy the files and
>   the descriptions would still be there.

The descriptions might make sense to _you_, _now_. No guarantee they make
any sense (or are in the least useful) for other users on your system, and
I might want them in arabic or some such. The descriptions might make no
sense to you in a couple of years.

>   Secondly, do you expect file managers like Nautilus and Konqueror to
>   support  every piece of file format on the planet so they could read
>   information directly from the documents?

That's their (self-selected) job, yes.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
