Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262166AbVAIAfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbVAIAfZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 19:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbVAIAfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 19:35:25 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:41925 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262166AbVAIAfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 19:35:21 -0500
Subject: Re: uselib()  & 2.6.X?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: Andreas Schwab <schwab@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m1zmzjv757.fsf@muc.de>
References: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl>
	 <20050107170712.GK29176@logos.cnet>
	 <1105136446.7628.11.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0501071609540.2386@ppc970.osdl.org>
	 <20050107221255.GA8749@logos.cnet>
	 <Pine.LNX.4.58.0501081042040.2386@ppc970.osdl.org>
	 <je8y73zl35.fsf@sykes.suse.de>  <m1zmzjv757.fsf@muc.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105227025.12004.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 08 Jan 2005 23:30:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-01-08 at 23:21, Andi Kleen wrote:
> > I don't think it was ever being used for anything besides a.out so IMHO it
> > should depend on BINFMT_AOUT.
> 
> I will disable it from 64bit x86-64. I would recommend that all other
> ELF only architectures do the same.

Presumably x86-64 runs 32bit a.out binaries however ? Disabling it now
is a bit pointless since its finally been audited 8)

