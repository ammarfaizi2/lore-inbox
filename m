Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbUL2NnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbUL2NnQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 08:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbUL2NnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 08:43:13 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:53954 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261344AbUL2NnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 08:43:08 -0500
Message-Id: <200412291342.iBTDgeKe007858@laptop11.inf.utfsm.cl>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve French <sfrench@samba.org>,
       Steve French <sfrench@us.ibm.com>,
       samba-technical <samba-technical@lists.samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/3] whitespace cleanups in fs/cifs/file.c 
In-Reply-To: Message from Jesper Juhl <juhl-lkml@dif.dk> 
   of "Wed, 29 Dec 2004 03:59:55 BST." <Pine.LNX.4.61.0412290347020.28589@dragon.hygekrogen.localhost> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Wed, 29 Dec 2004 10:42:40 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> said:
> On Wed, 29 Dec 2004, Jörn Engel wrote:
> 
> > On Wed, 29 December 2004 00:52:32 +0100, Jesper Juhl wrote:
> > > -		if(file->private_data != NULL) {
> > > +		if (file->private_data != NULL) {
> > 
> > 		if (file->private_data) {
> > 
> > It's a question of taste, but in most cases I consider the shorter
> > version to be more obvious.
> > 
> Yeah, matter of personal preference, but since both styles are used in the 
> file I had to pick one of them to try and make it consistent - I simply 
> picked my personally prefered form.

Nope. See Documentation/CodingStyle (it implicitly agrees with you, BTW).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
