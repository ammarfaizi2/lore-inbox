Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272156AbTG2VeM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 17:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272145AbTG2Vda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 17:33:30 -0400
Received: from c52038.upc-c.chello.nl ([212.187.52.38]:58756 "EHLO
	lintilla.koffie.nu") by vger.kernel.org with ESMTP id S272382AbTG2Vbb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 17:31:31 -0400
Message-ID: <XFMail.20030729233122.kernel@koffie.nu>
X-Mailer: XFMail 1.5.2 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
In-Reply-To: <8A3FF3E321C@vcnet.vc.cvut.cz>
Date: Tue, 29 Jul 2003 23:31:22 +0200 (CEST)
Organization: JBS Unix Solutions
From: Jan Huijsmans <kernel@koffie.nu>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test 2 & matroxfb or orinoco wifi card
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 29-Jul-2003 Petr Vandrovec wrote:
> On 29 Jul 03 at 22:35, Jan Huijsmans wrote:
>> After digging a bit in the archives I couldn't find the solution to my
>> problem, so I'm asking you guys.
> It is bug in matroxfb. I sent patch to Linus already, but it did not found
> its way through his email filters yet. I'll try again...

Hmmm, I found the patch, but that didn't help. (I suspect you're talking about
the matroxfb-2.5.72 patch mentioned on the list)

>> I found the "matroxfb and 2.6.0-test2" thread, so it's possible to compile
>> the
>> kernel with the matrox framebuffer, but I can't find what I'm missing. Did I
>> forget to set a config option (all copied from the 2.4.21 config except the
>> nForce2 agp chipset)?
> But anyway, you are trying to build your kernel without virtual terminal
> support (and, BTW, did you enable support for keyboard?) and it is probably
> not what you want. 

I found the keyboard setting, after which the VT support came available. Wierd
that I didn't find it myself, as my laptop has no problems with 2.6 (accept
that I need to recompile the pcmcia package) and it's not using a framebuffer.

It compiled without a problem this time. I'm afraid I have to test it tomorrow,
as my boss prefers me to be awake at work. (and I prefer to be awake when
driving there ;-))

---

Jan Huijsmans              kernel@koffie.nu

... cannot activate /dev/brain, no response from main coffee server


