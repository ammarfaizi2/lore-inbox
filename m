Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbVBXQoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVBXQoU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 11:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVBXQoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 11:44:20 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:3524 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S261598AbVBXQoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 11:44:16 -0500
Date: Thu, 24 Feb 2005 17:44:15 +0100
To: Bill Davidsen <davidsen@tmr.com>
Cc: Rog?rio Brito <rbrito@ime.usp.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11rc4: irq 5, nobody cared
Message-ID: <20050224164407.GC5138@vanheusden.com>
References: <20050220164010.GA17806@ime.usp.br> <421CF352.2090200@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421CF352.2090200@tmr.com>
Organization: www.unixexpert.nl
Read-Receipt-To: <folkert@vanheusden.com>
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
Reply-By: Fri Feb 25 17:07:35 CET 2005
X-MSMail-Priority: High
User-Agent: Mutt/1.5.6+20040907i
From: folkert@vanheusden.com (Folkert van Heusden)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>My linux laptop says:
> >>irq 5: nobody cared!
> >(...)
> >>Does anyone care? :-)
> >Well, I'm getting similar stack traces with my system and those are sure
> >scary, but it seems that my e-mails to the list are simply ignored,
> >unfortunately.
> I posted a similar thing, but the problem is not that you get the 
> message. It means your hardware generated an unexpected interrupt. The 
> kernel is reporting that fact as it should.
> The problem I had (not resolved) is that after the message
>   DISABLING IRQ NN
> I continued to get interrupts! So the logic to disable the IRQ is not 
> working correctly.

In my case, the interrupt should NOT be disabled as my WIFI-interface is
behind it (via ndiswrappers).

> as you note, because the hardware is generating the condition, no one 
> seems to care, even though there clearly is a problem in the disable 
> logic. I found a way to fix my hardware thanks to some pointers I got, 
> so I'm running, but I haven't heard that the base problem is fixed.

Aight.


Folkert van Heusden

Op zoek naar een IT of Finance baan? Mail me voor de mogelijkheden!
+------------------------------------------------------------------+
|UNIX admin? Then give MultiTail (http://vanheusden.com/multitail/)|
|a try, it brings monitoring logfiles to a different level! See    |
|http://vanheusden.com/multitail/features.html for a feature list. |
+------------------------------------------= www.unixsoftware.nl =-+
Phone: +31-6-41278122, PGP-key: 1F28D8AE
