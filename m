Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131590AbRC3Rnt>; Fri, 30 Mar 2001 12:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131595AbRC3Rnj>; Fri, 30 Mar 2001 12:43:39 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:51277 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S131590AbRC3Rn0>; Fri, 30 Mar 2001 12:43:26 -0500
Date: Fri, 30 Mar 2001 11:42:29 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Anton Safonov <Anton.Safonov@bestlinux.net>
cc: linux-kernel@vger.kernel.org, David Hinds <dhinds@zen.stanford.edu>
Subject: Re: PCMCIA problems on IBM ThinkPad 600X
In-Reply-To: <3AC47DD4.F4CC98BC@bestlinux.net>
Message-ID: <Pine.LNX.3.96.1010330114146.8826S-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Mar 2001, Anton Safonov wrote:

> Hi!
> 
> I have a problem with PCMCIA support on this IBM ThinkPad 600X.
> 
> kernel - 2.4.2 + patch-2.4.3-pre4
> pcmcia-cs - 3.1.25 (also tried with 3.1.23)
> 
> Then I insert a card (I'm trying now with two cards: 3COM 3CCFE575CT,
> D-Link DFE-680TX) the computer beeps and responds with:
> "cs: socket XXXXX timed out during reset"
> 
> 
> kernel config file is following:
> 
> #
> # PCMCIA/CardBus support
> #
> CONFIG_PCMCIA=m
> CONFIG_CARDBUS=y
> CONFIG_I82365=y
> CONFIG_TCIC=y

If you have CardBus support, do -not- define CONFIG_I82365 or
CONFIG_TCIC.

	Jeff



