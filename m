Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWG3F6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWG3F6d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 01:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWG3F6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 01:58:33 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:51399 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1751147AbWG3F6c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 01:58:32 -0400
Message-ID: <44CBE7FF.2030109@namesys.com>
Date: Sat, 29 Jul 2006 16:58:07 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <nikita@clusterfs.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: metadata plugins (was Re: the " 'official' point of view" expressed
 by kernelnewbies.org regarding reiser4 inclusion)
References: <200607281402.k6SE245v004715@laptop13.inf.utfsm.cl>	<44CA31D2.70203@slaphack.com>	<Pine.LNX.4.64.0607280859380.4168@g5.osdl.org>	<44C9FB93.9040201@namesys.com>	<44CA6905.4050002@slaphack.com>	<44CA126C.7050403@namesys.com>	<44CA8771.1040708@slaphack.com>	<44CABB87.3050509@namesys.com> <17611.21640.208153.492074@gargle.gargle.HOWL>
In-Reply-To: <17611.21640.208153.492074@gargle.gargle.HOWL>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:

>Hans Reiser writes:
> > David Masover wrote:
> > 
> > >
> > > If indeed it can be changed easily at all.  I think the burden is on
> > > you to prove that you can change it to be more generic, rather than
> > > saying "Well, we could do it later, if people want us to..."
> > 
> > None of the filesystems other than reiser4 have any interest in using
> > plugins, and this whole argument over how it should be in VFS is
> > nonsensical because nobody but us has any interest in using the
> > functionality.  The burden is on the generic code authors to prove that
> > they will ever ever do anything at all besides complain.  Frankly, I
> > don't think they will.  I think they will never produce one line of code.
> > 
> > Please cite one ext3 developer who is signed up to implement ext3 using
> > plugins if they are supported by VFS.
>
>In fact, they all do:
>
>struct inode_operations ext2_file_inode_operations;
>struct inode_operations ext2_dir_inode_operations;
>struct inode_operations ext2_special_inode_operations;
>struct inode_operations ext2_symlink_inode_operations;
>struct inode_operations ext2_fast_symlink_inode_operations;
>
>As you see, ext2 code already has multiple file "plugins", with
>persistent "plugin id" (stored in i_mode field of on-disk struct
>ext2_inode).
>
> > 
> > Hans
> > 
>
>Nikita.
>
>
>
>  
>
So the job is already done.  Good.  Reiser4 can be included then.:) 

Hans "The Easily Agreeable" Reiser
