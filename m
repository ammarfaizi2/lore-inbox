Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbUKVBOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbUKVBOu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 20:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbUKVBOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 20:14:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:4225 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261883AbUKVBNd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 20:13:33 -0500
Date: Sun, 21 Nov 2004 17:12:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Daniel Jacobowitz <dan@debian.org>, Eric Pouech <pouech-eric@wanadoo.fr>,
       Roland McGrath <roland@redhat.com>, Mike Hearn <mh@codeweavers.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <Pine.LNX.4.58.0411211511090.11274@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.58.0411211707280.20993@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
 <419E42B3.8070901@wanadoo.fr> <Pine.LNX.4.58.0411191119320.2222@ppc970.osdl.org>
 <419E4A76.8020909@wanadoo.fr> <Pine.LNX.4.58.0411191148480.2222@ppc970.osdl.org>
 <419E5A88.1050701@wanadoo.fr> <20041119212327.GA8121@nevyn.them.org>
 <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org> <20041120214915.GA6100@tesore.ph.cox.net>
 <Pine.LNX.4.58.0411211326350.11274@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0411211414460.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0411211511090.11274@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Nov 2004, Davide Libenzi wrote:
> 
> You know you're sick, don't you? Making traps inc's to get you in the 
> correct opcode to move function in edx->fnp, is indeed fruit of a sick 
> mind :=)

I prefer "creative" over "sick". It's so much less judgemental.

I thought it was a fun way to illustrate the issue, and I'm sure somebody 
had fun trying to figure out what the thing did.

I could have _obfuscated_ the thing if I had wanted to make it hard to 
follow, but instead I tried to make it as obvious as possible so that it's 
quite clear from reading the code what it actually does.

But imagine hitting that thing without seeing the source code. NOT a lot 
of fun to debug, even if the debugger _worked_ on it.

		Linus
