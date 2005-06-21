Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbVFUSYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbVFUSYK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 14:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbVFUSYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 14:24:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61145 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262154AbVFUSXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 14:23:55 -0400
Date: Tue, 21 Jun 2005 11:25:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: git-pull-script on my linus tree fails..
In-Reply-To: <42B859B4.5060209@pobox.com>
Message-ID: <Pine.LNX.4.58.0506211124310.2268@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506211304320.2915@skynet>
 <Pine.LNX.4.58.0506210837020.2268@ppc970.osdl.org> <42B838BC.8090601@pobox.com>
 <Pine.LNX.4.58.0506210905560.2268@ppc970.osdl.org> <42B84E20.7010100@pobox.com>
 <Pine.LNX.4.58.0506211039350.2268@ppc970.osdl.org> <42B8542A.9020700@pobox.com>
 <Pine.LNX.4.58.0506211103370.2268@ppc970.osdl.org> <42B859B4.5060209@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Jun 2005, Jeff Garzik wrote:
> 
> If git-checkout-script switches the .git/HEAD symlink properly, rather 
> than updating the symlink target's contents, then my git-switch-tree 
> script can just go away :)

Well, you should test it. I sure didn't ;)

It's there on master.kernel.org now, but it hasn't percolated to the 
mirrors (including webgit) yet. The thing that I _think_ should work has a 
top commit of "git checkout: fix default head case".

		Linus
