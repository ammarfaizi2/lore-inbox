Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262257AbVGFQzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbVGFQzr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 12:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbVGFQvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 12:51:14 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:52647 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262257AbVGFMdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 08:33:04 -0400
Message-Id: <200507060251.j662p7OC005227@laptop11.inf.utfsm.cl>
To: Hubert Chan <hubert@uhoreg.ca>
cc: Chet Hosey <chosey@nauticom.net>, Kevin Bowen <kevin@ucsd.edu>,
       Hans Reiser <reiser@namesys.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       David Masover <ninja@slaphack.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Message from Hubert Chan <hubert@uhoreg.ca> 
   of "Tue, 05 Jul 2005 16:55:33 -0400." <87pstxynui.fsf@evinrude.uhoreg.ca> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Tue, 05 Jul 2005 22:51:07 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Wed, 06 Jul 2005 08:30:03 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubert Chan <hubert@uhoreg.ca> wrote:
> On Fri, 01 Jul 2005 03:41:00 -0400, Chet Hosey <chosey@nauticom.net> said:
> > Horst von Brand wrote:
> >> And who says that a normal user isn't allowed to annotate each and
> >> every file with its purpose or something else?

> Explain how you currently allow users to annotate arbitrary files.

By keeping annotations /outside/ the files.

[...]

> The situation is even better with file-as-dir.  If the administrator
> wants to allow users to edit the description metadata for the file foo,
> the administrator can set the appropriate permissions for
> foo/.../description, and keep foo read-only.

So now root is responsible in exquisite detail for random other users being
able to keep info about my files?

[...]

> Actually, you could use something like unionfs to allow users to keep
> their own annotations without affecting everyone else's.

Again, root has to mount that stuff for each and every user?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
