Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267478AbTBLOss>; Wed, 12 Feb 2003 09:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267459AbTBLOss>; Wed, 12 Feb 2003 09:48:48 -0500
Received: from rrzs2.rz.uni-regensburg.de ([132.199.1.2]:40137 "EHLO
	rrzs2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S267478AbTBLOsr>; Wed, 12 Feb 2003 09:48:47 -0500
Date: Wed, 12 Feb 2003 15:58:36 +0100
From: Christian Guggenberger 
	<Christian.Guggenberger@physik.uni-regensburg.de>
To: rl@hellgate.ch, alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: via rhine bug? (timeouts and resets)
Message-ID: <20030212155836.A797@pc9391.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'd be happy to test via-rhine stuff, but my boxes don't generally like
>> 2.5.x so I can only usefully test 2.4.x fixes
> 
> No prob. AFAIK the only significant difference 2.4/2.5 is the change you
> made in 2.4.21pre4-ac1 (which, being short of IO-APIC hw, I can't test):
> 
> o       Always set interrupt line with VIA northbridge  (me)
>        | Should fix apic mode problems with USB/audio/net on VIA boards
> 
Can you please send a patch against 2.5.60, cause I would like to test these 
IO APIC things on my via board. 2.4-ac is no choice for me, since patching xfs 
into 2.4-ac is a little bit too painful for me;-)

Christian
