Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbTJAKOt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 06:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbTJAKOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 06:14:48 -0400
Received: from web40602.mail.yahoo.com ([66.218.78.139]:60281 "HELO
	web40602.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261763AbTJAKOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 06:14:46 -0400
Message-ID: <20031001101445.62739.qmail@web40602.mail.yahoo.com>
Date: Wed, 1 Oct 2003 11:14:45 +0100 (BST)
From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: APIC error on SMP machine
To: jamesclv@us.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>
Cc: R.E.Wolff@BitWizard.nl
In-Reply-To: <200309301852.47835.jamesclv@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- James Cleverdon <jamesclv@us.ibm.com> wrote:
> An APIC send accept error means that when trying to
> send an interrupt, it was not accepted by the
target. 
> In this case, the target is a CPU, either your other
> CPU or the same one (a CPU can send itself an 
> interrupt).
...
> 3) Maybe the other CPU is broken and physically
> cannot accept the interrupt.

Given the background, the most likely cause would seem
to be bad a CPU/motherboard connection. I have
realised that the APIC error is for CPU1, but I have
actually removed CPU0. And a bad CPU0 would explain
why "nosmp" didn't work either.

It's a pity that "nosmp" doesn't (logially cannot?)
take a "boot CPU number" as a parameter.

> Do any previous kernels boot?

Not any more. Everything started to hit the fan at the
beginning of August, and I thought that I had
"patched" things by underclocking the FSB. However,
that only seems to have delayed the inevitable. CPU
slot 2 on my motherboard just seems not to work any
more. I have no idea why - it's not like I can see a
lot of dust and dirt in there.

Oh well, I hear that Dell are selling dual 2.6 GHz
Xeons with RedHat preinstalled nowadays. (These should
have "hyperthreading support", right ;-) ?)

Cheers,
Chris


________________________________________________________________________
Want to chat instantly with your online friends?  Get the FREE Yahoo!
Messenger http://mail.messenger.yahoo.co.uk
