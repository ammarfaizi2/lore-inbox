Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264128AbTICSH7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 14:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264146AbTICSGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:06:52 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:53771 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S264128AbTICSF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:05:58 -0400
Date: Wed, 3 Sep 2003 15:07:49 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
X-X-Sender: marcelo@logos.cnet
To: Erik Andersen <andersen@codepoet.org>
Cc: steveb@unix.lancs.ac.uk, <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: corruption with A7A266+200GB disk?
In-Reply-To: <20030903013741.GA1601@codepoet.org>
Message-ID: <Pine.LNX.4.44.0309031507040.6102-100000@logos.cnet>
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

Alan (which has a clue about IDE unlike me) had complaints about your 
approach, right? 



