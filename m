Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270175AbTGMIem (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 04:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270177AbTGMIem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 04:34:42 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:39867
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270175AbTGMIem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 04:34:42 -0400
Subject: Re: hang with pcmcia wlan card
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wiktor Wodecki <wodecki@gmx.de>
Cc: Jaakko Niemi <liiwi@lonesom.pp.fi>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030712164855.GB2133@gmx.de>
References: <87fzldxcf5.fsf@jumper.lonesom.pp.fi>
	 <873chbyasi.fsf@jumper.lonesom.pp.fi>
	 <20030712173039.A17432@flint.arm.linux.org.uk>
	 <20030712164855.GB2133@gmx.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058086011.31919.39.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Jul 2003 09:46:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-07-12 at 17:48, Wiktor Wodecki wrote:
> > +      * If ISA interrupts don't work, then fall back to routing card
> > +      * interrupts to the PCI interrupt of the socket.
> > +      */
> > +     if (!socket->socket.irq_mask) {
> > +             int irqmux, devctl;
> > +

See the fix posted to the list a while ago and apply that and all should
be well. The change you refer to breaks for some setups

