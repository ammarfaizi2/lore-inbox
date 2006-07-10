Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161316AbWGJDTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161316AbWGJDTu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 23:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161317AbWGJDTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 23:19:50 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:51126 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1161316AbWGJDTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 23:19:49 -0400
Message-Id: <200607100318.k6A3Hcna031112@laptop11.inf.utfsm.cl>
To: Rob Landley <rob@landley.net>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Miniconfig revisited (2/3) 
In-Reply-To: Message from Rob Landley <rob@landley.net> 
   of "Sun, 09 Jul 2006 12:45:43 -0400." <200607091245.43880.rob@landley.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Sun, 09 Jul 2006 23:17:33 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Sun, 09 Jul 2006 23:19:39 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <rob@landley.net> wrote:
> On Saturday 08 July 2006 12:21 pm, Horst von Brand wrote:

[...]

> > > +# Loop through all lines in the file
> > > +I=1
> > > +while true
> > > +do
> > > +  if [ $I -gt $LENGTH ]
> > > +  then
> > > +    break
> > > +  fi
> >
> > Could do it with:
> >
> >   for I in $(seq 1 $LENGTH); do
> >     ...
> >   done

> Makes a 1/10th of a second difference to the final runtime, but if you
> prefer that...

I prefer it for readability.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
