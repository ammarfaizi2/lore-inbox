Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264026AbTE3WgT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 18:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264023AbTE3WgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 18:36:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40202 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264060AbTE3WgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 18:36:18 -0400
Date: Fri, 30 May 2003 15:49:12 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Davide Libenzi <davidel@xmailserver.org>
cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 Documentation/CodingStyle ANSI C function declarations.
In-Reply-To: <Pine.LNX.4.55.0305301535100.4421@bigblue.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.44.0305301546580.3089-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 May 2003, Davide Libenzi wrote:
> 
> Talking about the code, there are still a bunch of files that uses spaces
> with tabsize=4. Shouldn't those be reformatted with real TABs ? An emacs
> lisp (indent+tabify) might do it pretty fast ...

I don't generally like changing syntactic stuff without a reason.

A good reason is when the original maintainer is not that active any more,
and a new maintainer (or even just random fixer) feels that they need to
run indent on the sources in order to make them more readable before 
doign a fix.

It happens, but not very often. Alan and Al both do it to the files they 
clean up. But I don't like having it done "just because" - there should be 
a real underlying reason.

		Linus

