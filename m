Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262294AbUKKW6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbUKKW6u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 17:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbUKKW5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 17:57:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:37007 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262366AbUKKWx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 17:53:27 -0500
Date: Thu, 11 Nov 2004 14:53:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Matt Domsch <Matt_Domsch@dell.com>, Andrew Morton <akpm@osdl.org>
cc: Christian Kujau <evil@g-house.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pekka Enberg <penberg@gmail.com>, Greg KH <greg@kroah.com>
Subject: Re: Oops in 2.6.10-rc1 (almost solved)
In-Reply-To: <20041111224331.GA31340@lists.us.dell.com>
Message-ID: <Pine.LNX.4.58.0411111450580.2301@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411080951390.2301@ppc970.osdl.org>
 <418FDE1F.7060804@g-house.de> <419005F2.8080800@g-house.de>
 <41901DF0.8040302@g-house.de> <84144f02041108234050d0f56d@mail.gmail.com>
 <4190B910.7000407@g-house.de> <20041109164238.M12639@g-house.de>
 <Pine.LNX.4.58.0411091026520.2301@ppc970.osdl.org> <4191530D.8020406@g-house.de>
 <20041109234053.GA4546@lists.us.dell.com> <20041111224331.GA31340@lists.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Nov 2004, Matt Domsch wrote:
> 
> I haven't been able to find a solution to your problem yet, and given
> some external time constraints I've got, won't be able to look into
> this again for another week or more.

Matt, I'll revert the EXTENDED READ change for now, then. The random
behaviour of the problem it causes makes me really dislike this bug, and
I'd like to release a -rc2 and start calming down the 2.6.10 stuff, but
having known random stuff happen really disturbs me.

We can re-do it once it's more obvious why it broke..

		Linus
