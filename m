Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263952AbTGKVZe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 17:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265648AbTGKVZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 17:25:34 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:51384
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263952AbTGKVZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 17:25:31 -0400
Subject: Re: AMD760MPX: bogus chispset ? (was PROBLEM: sound is
	stutter,	sizzle with lasts kernel releases)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: xi <xizard@enib.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F0F2667.7090103@enib.fr>
References: <3F0EED9B.4080502@enib.fr>
	 <1057943291.20629.30.camel@dhcp22.swansea.linux.org.uk>
	 <3F0F2667.7090103@enib.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057959456.20637.45.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Jul 2003 22:37:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-07-11 at 22:04, xi wrote:
> And one interesting thing:
> in the AMD762 datasheet (24462.pdf) page 231 (Recommanded BIOS 
> settings), I can see this: "Numerical Values shown with h or b are 
> preferred settings." ; and AMD recommand this:
> -> set bits 2 and 1 of register 0x4C to "0b"
> -> set bits 23 and 3 respectively to "0b" and "1b"
> 
> I can confirm that these settings works much more better, even if they 
> don't exactly follow PCI specs. And I don't think this is specific to my 
>   cards since I have tested others.
> Furthermore, my AMD762 is revision B1 (just before the last one: C0), 
> and my AMD768 revision is B2, the last one.
> 
> Would you accept I make a patch which doesn't make any change in these 
> registers at least up to AMD762 revision B1 (ie keeping recommanded 
> values from AMD) ?

Lets try the AMD recommended settings. My old doc doesnt seem to have
those. I'll by happy to trial the patch in -ac and see if it plays up
the usual suspects for PCI spec violations (tg3 and i2o)

