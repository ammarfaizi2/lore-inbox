Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272831AbTG3Ipq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 04:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272833AbTG3Ipq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 04:45:46 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:30479 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S272831AbTG3Inq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 04:43:46 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] O11int for interactivity
Date: Wed, 30 Jul 2003 10:43:22 +0200
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200307301038.49869.kernel@kolivas.org> <1059553792.548.2.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1059553792.548.2.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307301040.38858.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 July 2003 10:29, Felipe Alfaro Solana wrote:

Hi Felipe,

> I'm running 2.6.0-test2-mm1 + O11int.patch + O11.1int.patch and I must
> say this is getting damn good! In the past, I've had to tweak scheduler
> knobs to tune the engine to my taste, but since O10, this is a thing of
> the past. It's working as smooth as silk...
> Good work!
I really really wonder why I don't experience this behaviour. For me, the best 
scheduler patch in the past was the one from you. I had a test last night 
with 011.1 and I rebooted into 2.4 back after some hours of testing because 
it is unusable for me under load, and it is no heavy load, it's just for 
example a simple "make -j2 bzImage modules".

What makes me even more wondering is that 2.6.0-test1-wli tree does not suck 
at all for interactivity where no scheduler changes were made.

Maybe we need both: VM fixups (we need them anyway!) and O(1) fixups so that
                    also my machine will be happy ;)

ciao, Marc

