Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271950AbRHVK3v>; Wed, 22 Aug 2001 06:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271958AbRHVK3b>; Wed, 22 Aug 2001 06:29:31 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59147 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271953AbRHVK32>; Wed, 22 Aug 2001 06:29:28 -0400
Subject: Re: Qlogic/FC firmware
To: jfbeam@bluetopia.net (Ricky Beam)
Date: Wed, 22 Aug 2001 11:32:35 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.33.0108220031190.6389-100000@sweetums.bluetronic.net> from "Ricky Beam" at Aug 22, 2001 01:19:58 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZVJL-0001HR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We aren't talking about a module when it's compiled into the kernel.  In
> the case(s) of modules, there are many ways to provide data (such as
> firmware) without the aforementioned bloat everyone wants to bitch about.

Like loading it from user space. Which is exactly the same code needed
for an initrd. Amazing isn it.

> And I'd like to point out the people screaming about bloat do not have
> the hardware for which this driver is required and thusly will *never*

Wrong. I object to wasting 128K and I have fibrechannel. Its that kind of
sloppy "who cares about 128K" thinking that leads to several megs
disappearing and your OS turning into sludge. 

> So basically, you had no fucking clue what kind of instability you were about
> to introduce into the current "stable" line of kernels, but did it anyway

It caused a trivial little problem for a few sparc people which basically has 
only been more than a

	"Hey Alan, sparc needs firmware compiled in can you fix"

because it seems you have to be arrogant and opinionated to own a sparc64
box 8)

> the file was entered into the tree.  If there were objections, questions,
> or other concerns, they should have been raised then and not months or years
> later.  And there should have been at least some discussion before removing

Take that one up with Linus. I didn't merge it originally

Alan
