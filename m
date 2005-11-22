Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965150AbVKVTmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965150AbVKVTmk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965151AbVKVTmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:42:40 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:25549 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965150AbVKVTmj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:42:39 -0500
Subject: Re: [RFC] Small PCI core patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthieu CASTET <castet.matthieu@free.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <pan.2005.11.22.18.26.54.534251@free.fr>
References: <20051121225303.GA19212@kroah.com>
	 <20051121230136.GB19212@kroah.com> <pan.2005.11.22.18.26.54.534251@free.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Nov 2005 20:15:09 +0000
Message-Id: <1132690509.20233.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-11-22 at 19:26 +0100, Matthieu CASTET wrote:
> Why not make a crappy GPL driver that just export again
> the symbols ?

Because if you have to do tha your non GPL driver is a derivative work
of your GPL driver and clearly GPL. More to the point any court of law
is going to look at your behaviour and conclude that it was deliberate
infringing behaviour, which is normally either criminal and/or scores
triple damages. It may also count as circumvention, and that was one
reason to add the module license/_GPL check - so that blatent abuse
would fall under DMCA/EUCD. If the bad guys are going to have insane
laws and penalties available to use against people, then it makes sense
for the good guys to carry the same sized stick.

Note btw there is a very big difference between circumvention/blatant
GPL violation and some of the other cases being discussed.

> Also why as an embeded company I can't remove the licence check in the
> kernel I provide to my custommers.

Nothing stops you. But see above as it applies likewise. 

Alan
