Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316592AbSGLPGQ>; Fri, 12 Jul 2002 11:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316594AbSGLPGP>; Fri, 12 Jul 2002 11:06:15 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22277 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316592AbSGLPGO>; Fri, 12 Jul 2002 11:06:14 -0400
Subject: Re: Advice saught on math functions
To: kirk@braille.uwo.ca (Kirk Reiser)
Date: Fri, 12 Jul 2002 16:32:19 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <x7ptxtdmnc.fsf@speech.braille.uwo.ca> from "Kirk Reiser" at Jul 12, 2002 10:52:07 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17T2P5-0003DF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you give me more details?  I certainly don't mind looking into
> this as a possible solution.  Are you willing to give up seeing
> anything on the screen until init gets started?

This is how Nicholas stuff works, you can still get the kernel messages
by scrolling back. I'm told this meets S508.

> include speech and review capabilities from power up to power down.
> Open BIOS and Linux for the first time ever can provide a way for the
> blind community to not be a second class citizen to information
> access.  I am afraid that if I just take the emacspeak approach to
> accessibility then my community will stay beholding to others for
> their access to available information.  I am sorry about the soap-box
> preaching but it is a fundamental problem with just user space
> solutions.

Actually some of this is true for sighted people. You only get console
messages after PCI is initialised, until then they are queued away or
only on serial console.

If you are using a conventional BIOS then the first kernel messages being
readable as they occur versus just after seems to have only a little value.
If you have a fully accessible LinuxBIOS thats something quite different.
In that case can you use a Linuxbios hook for the console speech until
user space takes over ?

Alan
