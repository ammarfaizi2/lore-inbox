Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263012AbVBCNzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbVBCNzi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 08:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263615AbVBCNzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 08:55:38 -0500
Received: from moutng.kundenserver.de ([212.227.126.176]:33274 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263035AbVBCNzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 08:55:22 -0500
From: Peter Busser <busser@m-privacy.de>
Organization: m-privacy
To: pageexec@freemail.hu
Subject: Re: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack pointer)
Date: Thu, 3 Feb 2005 14:55:21 +0100
User-Agent: KMail/1.7.1
References: <4201DBE7.30569.2F5D446@localhost>
In-Reply-To: <4201DBE7.30569.2F5D446@localhost>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502031455.22100.busser@m-privacy.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e784f4497a7e52bfc8179ee7209408c3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 February 2005 23:08, pageexec@freemail.hu wrote:
> > and how do you force a program to call that function and then to execute
> > your shellcode? In other words: i challenge you to show a working
> > (simulated) exploit on Fedora (on the latest fc4 devel version, etc.)
> > that does that.

Ingo is assuming a best-case scenario here. Assumptions are the mother of all 
fuckups. This discussion does not address issues which arise when:

- You compile code with different compilers (say, OCaml, tcc, Intel Compiler, 
or whatever)
- What happens when you run existing commercial applications which have not 
been compiled using GCC.
- What happens when you mix GCC compiled code with other code (e.g. a 
commercial Motif library).
- What happens when you link libraries compiled with older GCC versions?
- And so on and so forth.

It can be fun to dive into a low-level details discussion. But unless you 
solved the higher level issues, the whole discussion is just a waste of time. 
And these higher level issues won't be fixed unless people start to properly 
address worst-case behaviour, like any sensible engineer would do.

> i don't have any Fedora but i think i know roughly what you're doing,
> if some of the stuff below wouldn't work, let me know.

You've tried to educate these people before. You're wasting your time and 
talent. I think you should ask for a handsome payment when these people want 
to enjoy the privilege of being properly educated by someone who knows what 
he's talking about.

Groetjes,
Peter.
