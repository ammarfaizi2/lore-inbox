Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267740AbUIJSQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267740AbUIJSQl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 14:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267748AbUIJSQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 14:16:41 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:63134 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S267740AbUIJSQh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 14:16:37 -0400
Message-Id: <200409101815.i8AIFc5i005300@localhost.localdomain>
To: Hans Reiser <reiser@namesys.com>
cc: Timothy Miller <miller@techsource.com>,
       Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>,
       Jamie Lokier <jamie@shareable.org>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4 
In-Reply-To: Message from Hans Reiser <reiser@namesys.com> 
   of "Fri, 10 Sep 2004 10:51:27 MST." <4141E99F.5060303@namesys.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Fri, 10 Sep 2004 14:15:38 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> said:
> Timothy Miller wrote:

[...]

> > You know, if tools all need to be rewritten anyway to deal with the 
> > file metadata "directory", then why not change the symbol that 
> > delimits the metadata key?

> because it is useful that it is only a style convention.  Changing the 
> symbol makes it mandatory to distinguish metafiles from files.

If they are really different than directories, it should be clear what is
what, IMVHO. If they aren't different, they have no place here. Trying to
break hoary Unix tradition (files and directories are separate) while
pretending nothing has changed (see, a file can be handled just like a
directory) just doesn't cut it.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
