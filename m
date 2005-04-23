Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVDWTcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVDWTcb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 15:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVDWTcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 15:32:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:8608 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261652AbVDWTc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 15:32:27 -0400
Date: Sat, 23 Apr 2005 12:34:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Sean <seanlkml@sympatico.ca>
cc: David Woodhouse <dwmw2@infradead.org>, Jan Dittmer <jdittmer@ppp0.net>,
       Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Git-commits mailing list feed.
In-Reply-To: <2646.10.10.10.24.1114278656.squirrel@linux1>
Message-ID: <Pine.LNX.4.58.0504231232260.2344@ppc970.osdl.org>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>          
 <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>          
 <426A4669.7080500@ppp0.net>           <1114266083.3419.40.camel@localhost.localdomain>
           <426A5BFC.1020507@ppp0.net>          <1114266907.3419.43.camel@localhost.localdomain>
          <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
 <2646.10.10.10.24.1114278656.squirrel@linux1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 23 Apr 2005, Sean wrote:
> 
> Why not leave tags open to being signed or unsigned?

That is exactly what my proposal does, except I'd make the normal tags 
creation always sign.

But since _git_ won't care which is why I want the signature at the _end_, 
not "surrpunding" the thing, you could create a tag that just doesn't have 
the signature, and git will never even notice. The people who see the tag 
may say "hmm, why couldn't he be bothered to sign it", though.

		Linus

