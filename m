Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270194AbTGMJfr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 05:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270195AbTGMJfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 05:35:47 -0400
Received: from ip212-226-133-178.adsl.kpnqwest.fi ([212.226.133.178]:64399
	"EHLO jumper") by vger.kernel.org with ESMTP id S270194AbTGMJfq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 05:35:46 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Wiktor Wodecki <wodecki@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: hang with pcmcia wlan card
References: <87fzldxcf5.fsf@jumper.lonesom.pp.fi>
	<873chbyasi.fsf@jumper.lonesom.pp.fi>
	<20030712173039.A17432@flint.arm.linux.org.uk>
	<20030712164855.GB2133@gmx.de>
	<1058086011.31919.39.camel@dhcp22.swansea.linux.org.uk>
From: Jaakko Niemi <liiwi@lonesom.pp.fi>
Date: Sun, 13 Jul 2003 12:50:33 +0300
In-Reply-To: <1058086011.31919.39.camel@dhcp22.swansea.linux.org.uk> (Alan
 Cox's message of "13 Jul 2003 09:46:52 +0100")
Message-ID: <87wuemg3h2.fsf@jumper.lonesom.pp.fi>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Sad, 2003-07-12 at 17:48, Wiktor Wodecki wrote:
>> > +      * If ISA interrupts don't work, then fall back to routing card
>> > +      * interrupts to the PCI interrupt of the socket.
>> > +      */
>> > +     if (!socket->socket.irq_mask) {
>> > +             int irqmux, devctl;
>> > +
>
> See the fix posted to the list a while ago and apply that and all should
> be well. The change you refer to breaks for some setups

 Was the fix against drivers/pcmcia/ti113x.h ? (other than backing off
 that patch..). If so, then I'm unable to locate it. Looks like I need
 local lkml archive anyway :)

                    --j
