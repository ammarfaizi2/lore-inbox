Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272494AbTHKKsz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 06:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272500AbTHKKsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 06:48:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48901 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S272494AbTHKKsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 06:48:54 -0400
Date: Mon, 11 Aug 2003 11:48:50 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Santiago Garcia Mantinan <manty@manty.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test3 problems on Acer TravelMate 260 (ALSA,ACPIvsSynaptics,yenta)
Message-ID: <20030811114850.E32508@flint.arm.linux.org.uk>
Mail-Followup-To: Santiago Garcia Mantinan <manty@manty.net>,
	linux-kernel@vger.kernel.org
References: <20030811102236.GA731@man.beta.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030811102236.GA731@man.beta.es>; from manty@manty.net on Mon, Aug 11, 2003 at 12:22:36PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 12:22:36PM +0200, Santiago Garcia Mantinan wrote:
> There are some weird old problems, like the yenta problem, the problem with
> the cardbus interface is that you have to insert the card twice so that it
> notices the card is in, everything else seems ok, on 2.4 there is the same
> problem, so I'm using the pcmcia-cs i82365 driver which is working
> perfectly. This is what the 2.6 yenta driver says on startup:
> 
> Yenta: CardBus bridge found at 0000:01:09.0 [1025:1024]
> Yenta IRQ list 02b8, PCI irq10
> Socket status: 30000007

Please supply the following information:

- does 2.6.0-test3 detect the card at boot ?
  - if not, what are the complete kernel messages ?

- does 2.6.0-test3 detect it at every insertion after the first
  "insert remove insert" cycle, or does it always need an even
  number of insertions for it to be recognised?

- does 2.4 and 2.6-test3 yenta find the same IRQs ?

- which version of pcmcia-cs are you using with 2.4 ?

- which IRQ(s) does 2.4 i82365 use ?


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

