Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWG0UsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWG0UsS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 16:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWG0UsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:48:18 -0400
Received: from mail.gmx.net ([213.165.64.21]:33155 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750781AbWG0UsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:48:18 -0400
X-Authenticated: #1490710
Date: Thu, 27 Jul 2006 22:48:16 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Nasty git corruption problem
In-Reply-To: <Pine.LNX.4.64.0607271206461.4168@g5.osdl.org>
Message-ID: <Pine.LNX.4.63.0607272247420.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1153929715.13509.12.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0607260945440.29649@g5.osdl.org> 
 <Pine.LNX.4.63.0607261935160.29667@wbgn013.biozentrum.uni-wuerzburg.de> 
 <Pine.LNX.4.64.0607261039380.29649@g5.osdl.org>  <Pine.LNX.4.64.0607261041490.29649@g5.osdl.org>
 <1154025127.13509.90.camel@localhost.localdomain> <Pine.LNX.4.64.0607271206461.4168@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 27 Jul 2006, Linus Torvalds wrote:

> On Thu, 27 Jul 2006, Alan Cox wrote:
> > 
> > git-lost-found turns up some of the missing stuff that was applied
> > earliest in the rebase but the other stuff is apparently neither visible
> > anywhere in the tree or missing (the tree I was rebasing "^^^..." never
> > shows it nor does the log).
> 
> Did you try "git-fsck-objects --full"?
> 
> The git-lost-found script is apparently broken, exactly because it doesn't 
> do a "full".

Of course, I was assuming that nothing like repacking or pruning took 
place after the crash...

Ciao,
Dscho

