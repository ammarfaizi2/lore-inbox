Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264423AbTICTzO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 15:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264409AbTICTxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 15:53:47 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:41741 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S264362AbTICTwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 15:52:02 -0400
Date: Wed, 3 Sep 2003 16:54:28 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
X-X-Sender: marcelo@logos.cnet
To: Erik Andersen <andersen@codepoet.org>
Cc: steveb@unix.lancs.ac.uk, <linux-kernel@vger.kernel.org>
Subject: Re: corruption with A7A266+200GB disk?
In-Reply-To: <20030903013741.GA1601@codepoet.org>
Message-ID: <Pine.LNX.4.44.0309031653290.6102-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Sep 2003, Erik Andersen wrote:

> On Tue Sep 02, 2003 at 02:28:16PM +0100, steveb@unix.lancs.ac.uk wrote:
> > 
> > I just got a new 200GB disk (WDC WD2000JB) for my home machine (Asus A7A266,
> > Ali chipset). I put some partitions on it like so:
> >   hda1:   100MB - /boot
> >   hda2:  8192MB - /
> >   hda3:  1024MB - swap
> >   hda4:  the rest (about 190GB I guess) - /home
> > 
> > I find that when I mkfs on /home, I get massive filesystem corruption on /
> > When I fsck / (and restore the deleted files) I get massive filesystem corruption on /home. Luckily all my real data is still on my old disk...
> > 
> > I reduced the size of /home to 40GB and everything was fine.
> > I see the same behaviour with both 2.6.0test3 and 2.4.22.
> 
> Known problem.  For some reason Marcelo has not yet applied 
> the fix for this problem to the 2.4.x kernels...

So it seems the fix is already in 2.4.23-pre2 (came in through Alan IDE
changes). 

Steve, it seems 2.4.23-pre2 fixes your problem. 

