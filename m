Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVAHWxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVAHWxk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 17:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVAHWxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 17:53:39 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:27845 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261233AbVAHWv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 17:51:57 -0500
Subject: Re: uselib()  & 2.6.X?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0501081042040.2386@ppc970.osdl.org>
References: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl>
	 <20050107170712.GK29176@logos.cnet>
	 <1105136446.7628.11.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0501071609540.2386@ppc970.osdl.org>
	 <20050107221255.GA8749@logos.cnet>
	 <Pine.LNX.4.58.0501081042040.2386@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105217148.10505.82.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 08 Jan 2005 21:47:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-01-08 at 18:46, Linus Torvalds wrote:
> They mostly don't _need_ the lock (at least not the binary loader ones),
> since at executable loading time you're guaranteed to be the only user
> anyway

Still unconvinced looking in fs/proc. 
