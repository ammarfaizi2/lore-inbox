Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262421AbREXWV4>; Thu, 24 May 2001 18:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262413AbREXWVq>; Thu, 24 May 2001 18:21:46 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14344 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262418AbREXWVb>; Thu, 24 May 2001 18:21:31 -0400
Subject: Re: SyncPPP Generic PPP merge
To: paulkf@microgate.com (Paul Fulghum)
Date: Thu, 24 May 2001 23:18:58 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <002501c0e48f$ffed1e40$0c00a8c0@diemos> from "Paul Fulghum" at May 24, 2001 02:27:48 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1533Ra-0005hC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Instead of using ifconfig to bring an interface
> up or down, the user must now work with pppd. And the net
> device naming changes (allocated by ppp_generic.c instead
> of using the net device allocated by low level driver).

I suspect that bit can be fixed if need be. Its nice to keep a constant 
naming between cisco/ppp modes. cisco/ppp autodetect is also possible and would
be rather nice to support 

> Or is it to *add* generic PPP support to syncppp,
> leaving (at least temporarily) the existing PPP 
> capability in syncppp for compatibility?
> (implying a new syncppp flag USE_GENERIC_PPP?)

Assuming this is a 'when 2.5 starts' discussion I'd like initially to keep the
syncppp api is but the pppd code going via generic ppp - and yes it would
break configs.

Clearly thats not 2.4 acceptable

