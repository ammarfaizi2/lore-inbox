Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbVIDWBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbVIDWBA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 18:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbVIDWBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 18:01:00 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:58816 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932088AbVIDWA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 18:00:59 -0400
Message-Id: <200509042147.j84LlSl3020442@laptop11.inf.utfsm.cl>
To: Andreas Hartmann <andihartmann@01019freenet.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: forbid to strace a program 
In-Reply-To: Message from Andreas Hartmann <andihartmann@01019freenet.de> 
   of "Sun, 04 Sep 2005 00:23:50 +0200." <dfd7pm$1c2$1@pD9F86CE8.dip0.t-ipconnect.de> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Sun, 04 Sep 2005 17:47:28 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Hartmann <andihartmann@01019freenet.de> wrote:
1> Alex Riesen wrote:
> > On 9/3/05, Andreas Hartmann <andihartmann@01019freenet.de> wrote:
> >> Hello!
> >> Is it possible to prevent a program to be straced on x86?
> >> What do I have to do, eg., to prevent a perl-program to be straced?

Look at the contortions shc does for this.

> > So that none can see what are you doing? Or because your program is
> > breaking because of this? Probably nothing, but someone would like
> > to know what it is you are doing and exactly how it breaks (and, if
> > you don't mind -
> > why it breaks).

> That's not really the problem. I want to hide a clear text password in
> that program (something like ssh-agent or gpg-agent; the last can be
> straced, too :-() which I need for a database when the program runs.

Anyone who can read the executable can find that out. In the worst case, by
running it in a doctored environment that catches the password.

Place it in a file that noone else can read, that way it is also easier to
change.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
