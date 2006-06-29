Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWF2MvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWF2MvO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 08:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWF2MvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 08:51:14 -0400
Received: from smtp4.poczta.interia.pl ([80.48.65.7]:15136 "EHLO
	smtp4.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S1750817AbWF2MvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 08:51:14 -0400
Message-ID: <44A3CCB0.7080208@interia.pl>
Date: Thu, 29 Jun 2006 14:50:56 +0200
From: =?ISO-8859-2?Q?Rafa=B3_Bilski?= <rafalbilski@interia.pl>
User-Agent: Thunderbird 1.5.0.4 (X11/20060628)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (Longhaul 1/5) PCI: Protect bus master DMA from	Longhaul
 by rw semaphores
References: <44A2C9A7.6060703@interia.pl> <1151581077.23785.9.camel@localhost.localdomain> <44A3C17F.3060204@etpmod.phys.tue.nl>
In-Reply-To: <44A3C17F.3060204@etpmod.phys.tue.nl>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-EMID: 14d1cacc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart Hartgers napisa³(a):
> Alan Cox wrote:
>> Ar Mer, 2006-06-28 am 20:25 +0200, ysgrifennodd Rafa³ Bilski:
>>> AUTOHALT, this means interrupts must be disabled except for the time tick, 
>>> which should be reset to >=1ms. Care must be taken to avoid other system events 
>>> that could interfere with this operation. A few examples are snooping, NMI, 
>>> INIT, SMI and FLUSH."
>> "snooping". So we do need the cache sorting out.
>>
> 
> If I understand correctly, trouble occurs when the processor tries to
> snoop? Would disabling (via MSR) and flushing the caches before changing
> the frequency help in that case?
> 
> Groeten,
> Bart
> 

I will check that. If this was so simple all this time...
I hope this "few examples" aren't many more.

Rafa³


----------------------------------------------------------------------
PS. Fajny portal... >>> http://link.interia.pl/f196a

