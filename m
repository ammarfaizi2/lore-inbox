Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272829AbTG3Ji3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 05:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272838AbTG3Ji3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 05:38:29 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:20409
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272829AbTG3Ji2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 05:38:28 -0400
Message-ID: <1059557903.3f27920f97d4a@kolivas.org>
Date: Wed, 30 Jul 2003 19:38:23 +1000
From: Con Kolivas <kernel@kolivas.org>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O11int for interactivity
References: <200307301038.49869.kernel@kolivas.org> <1059553792.548.2.camel@teapot.felipe-alfaro.com> <200307301040.38858.m.c.p@wolk-project.de>
In-Reply-To: <200307301040.38858.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marc-Christian Petersen <m.c.p@wolk-project.de>:

> On Wednesday 30 July 2003 10:29, Felipe Alfaro Solana wrote:
> 
> Hi Felipe,
> 
> > I'm running 2.6.0-test2-mm1 + O11int.patch + O11.1int.patch and I must
> > say this is getting damn good! In the past, I've had to tweak scheduler
> > knobs to tune the engine to my taste, but since O10, this is a thing of
> > the past. It's working as smooth as silk...
> > Good work!
> I really really wonder why I don't experience this behaviour. For me, the
> best 
> scheduler patch in the past was the one from you. I had a test last night 
> with 011.1 and I rebooted into 2.4 back after some hours of testing because 
> it is unusable for me under load, and it is no heavy load, it's just for 
> example a simple "make -j2 bzImage modules".
> 
> What makes me even more wondering is that 2.6.0-test1-wli tree does not suck
> 
> at all for interactivity where no scheduler changes were made.
> 
> Maybe we need both: VM fixups (we need them anyway!) and O(1) fixups so that
>                     also my machine will be happy ;)

The obvious question still needs to be asked here. How does vanilla compare to
vanilla +O11.1?

Con
