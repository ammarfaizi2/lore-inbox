Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbUL2Qb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbUL2Qb5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 11:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbUL2Qb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 11:31:57 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:38563 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261366AbUL2Qbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 11:31:55 -0500
Message-Id: <200412291631.iBTGVQkc008538@laptop11.inf.utfsm.cl>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Jesper Juhl <juhl-lkml@dif.dk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve French <sfrench@samba.org>,
       Steve French <sfrench@us.ibm.com>,
       samba-technical <samba-technical@lists.samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/3] whitespace cleanups in fs/cifs/file.c 
In-Reply-To: Message from =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de> 
   of "Wed, 29 Dec 2004 15:48:53 BST." <20041229144853.GA5435@wohnheim.fh-wedel.de> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Wed, 29 Dec 2004 13:31:26 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de> said:
> On Wed, 29 December 2004 10:42:40 -0300, Horst von Brand wrote:
> > Jesper Juhl <juhl-lkml@dif.dk> said:
> > > On Wed, 29 Dec 2004, Jörn Engel wrote:
> > > > On Wed, 29 December 2004 00:52:32 +0100, Jesper Juhl wrote:
> > > > > -		if(file->private_data != NULL) {
> > > > > +		if (file->private_data != NULL) {
> > > > 
> > > > 		if (file->private_data) {
> > > > 
> > > > It's a question of taste, but in most cases I consider the shorter
> > > > version to be more obvious.
> > > > 
> > > Yeah, matter of personal preference, but since both styles are used in the 
> > > file I had to pick one of them to try and make it consistent - I simply 
> > > picked my personally prefered form.
> > 
> > Nope. See Documentation/CodingStyle (it implicitly agrees with you, BTW).
> 
> Can you be more specific?  Did you mean the "if (x is true) {" part?

That, and NULL is mentioned only in a == NULL construction.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
