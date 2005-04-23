Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVDWAT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVDWAT3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 20:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVDWAT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 20:19:28 -0400
Received: from fire.osdl.org ([65.172.181.4]:48523 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261398AbVDWATX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 20:19:23 -0400
Date: Fri, 22 Apr 2005 17:21:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
cc: Petr Baudis <pasky@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3
In-Reply-To: <20050422231839.GC1789@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0504221718410.2344@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>
 <20050421112022.GB2160@elf.ucw.cz> <20050421120327.GA13834@elf.ucw.cz>
 <20050421162220.GD30991@pasky.ji.cz> <20050421232201.GD31207@elf.ucw.cz>
 <20050422002150.GY7443@pasky.ji.cz> <20050422231839.GC1789@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 23 Apr 2005, Pavel Machek wrote:
> 
> Unfortunately first merge will make it practically unusable :-(. 

No, quite the reverse. If I merge from you, and you use my commit ID as 
the "base" point, it will work again.

But yes, if you actually send the result as _patches_ to me, then the 
commit objects I create will be totally separate from the commit objects 
you had in your tree, and "git-export" will continue to export your old 
stale entries since they won't show up as already being in my tree.

The point being, that there is a big difference between a proper merge 
(with history etc merged) and just sending me the patches in your tree.

		Linus
