Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262353AbVDXRqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbVDXRqB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 13:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbVDXRqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 13:46:01 -0400
Received: from fire.osdl.org ([65.172.181.4]:45446 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262353AbVDXRp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 13:45:59 -0400
Date: Sun, 24 Apr 2005 10:44:43 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Greg KH <greg@kroah.com>, pavel@ucw.cz, drzeus-list@drzeus.cx,
       pasky@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.12-rc3
In-Reply-To: <20050424032622.3aef8c9f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0504241038350.15879@ppc970.osdl.org>
References: <20050421162220.GD30991@pasky.ji.cz> <20050421232201.GD31207@elf.ucw.cz>
 <20050422002150.GY7443@pasky.ji.cz> <20050422231839.GC1789@elf.ucw.cz>
 <Pine.LNX.4.58.0504221718410.2344@ppc970.osdl.org> <20050423111900.GA2226@openzaurus.ucw.cz>
 <Pine.LNX.4.58.0504230654190.2344@ppc970.osdl.org> <426A7775.60207@drzeus.cx>
 <20050423220213.GA20519@kroah.com> <20050423222946.GF1884@elf.ucw.cz>
 <20050423233809.GA21754@kroah.com> <20050424032622.3aef8c9f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 24 Apr 2005, Andrew Morton wrote:
> 
> - How do I do a bk `gcapatch' is there is no Linus bk tree to base it off?

"gcapatch" should be trivial if I have understood it correctly, and git
can already do it. I've never used it, though, and in a mixed git/bk
environment you probably want to use bk to do these things and just import
things from git, if only because bk will be better at merging things
automatically.

Also, exporting from git->bk looks like it should be very easy and 
automatable efficiently. "SMOP".

		Linus
