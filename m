Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262278AbVGLDb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbVGLDb4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 23:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbVGLDb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 23:31:56 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:29600 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262278AbVGLDal (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 23:30:41 -0400
Message-Id: <200507120233.j6C2XODw030361@laptop11.inf.utfsm.cl>
To: Hans Reiser <reiser@namesys.com>
cc: Stefan Smietanowski <stesmi@stesmi.com>,
       David Masover <ninja@slaphack.com>, Hubert Chan <hubert@uhoreg.ca>,
       Ross Biro <ross.biro@gmail.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>,
       Alexander Zarochentcev <zam@namesys.com>, vs <vs@thebsh.namesys.com>,
       Nate Diller <ndiller@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Message from Hans Reiser <reiser@namesys.com> 
   of "Mon, 11 Jul 2005 15:58:11 MST." <42D2F983.1060105@namesys.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Mon, 11 Jul 2005 22:33:24 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:
> Stefan Smietanowski wrote:
> > I think "..." and ".meta" both serve as a logical delimiter. However
> > some programs implement their own "..." which would make it clash with
> > them. Naturally if some program created a directory called .meta we're
> > equally screwed.

> I chose '....' (four dots) because it clashes with less, not three dots.

Is this some kind of "My dots are more than yours" contest?!

/None/ of them is safe. ".meta", "...", "....", ".this.has.five.dots." are
all perfectly legal file (or directory) names, POSIXly. If any one of them
won't do, none will.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
