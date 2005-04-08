Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262935AbVDHTaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262935AbVDHTaW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 15:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262937AbVDHTaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 15:30:22 -0400
Received: from fire.osdl.org ([65.172.181.4]:13959 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262935AbVDHTaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 15:30:18 -0400
Date: Fri, 8 Apr 2005 12:32:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
cc: Andrea Arcangeli <andrea@suse.de>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
In-Reply-To: <4256D87C.5090207@tiscali.de>
Message-ID: <Pine.LNX.4.58.0504081231130.28951@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
 <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
 <20050408071428.GB3957@opteron.random> <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org>
 <4256AE0D.201@tiscali.de> <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org>
 <4256BE7D.5040308@tiscali.de> <Pine.LNX.4.58.0504081047200.28951@ppc970.osdl.org>
 <4256D87C.5090207@tiscali.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Apr 2005, Matthias-Christian Ott wrote:
>
> But as mentioned you need to _open_ each file (It doesn't matter if it's 
> cached (this speeds up only reading it) -- you need a _slow_ system call 
> and _very slow_ hardware access anyway).

Nope. System calls aren't slow. What crappy OS are you running?

> I hope my idea/opinion is clear now.

Numbers talk. I've got something that you can test ;)

		Linus
