Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbSKRKti>; Mon, 18 Nov 2002 05:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262067AbSKRKti>; Mon, 18 Nov 2002 05:49:38 -0500
Received: from poup.poupinou.org ([195.101.94.96]:8223 "EHLO poup.poupinou.org")
	by vger.kernel.org with ESMTP id <S262038AbSKRKth>;
	Mon, 18 Nov 2002 05:49:37 -0500
Date: Mon, 18 Nov 2002 11:56:31 +0100
To: Michael Knigge <Michael.Knigge@set-software.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.xx: 8139 isn't working
Message-ID: <20021118105631.GA27595@poup.poupinou.org>
References: <20021118.10200352@knigge.local.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021118.10200352@knigge.local.net>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 10:20:03AM +0000, Michael Knigge wrote:
> Hi,
> 
> my new board (GA-8ST, P4, single-CPU, SiS Chipset) has a RealTek 8139 
> on board which isn't working with Linux 2.4.xx (tried 2.4.18, 2.4.19, 
> 2.4.20rc1 and  2.4.20rc2).
> 
> I've attached lspci, dmesg and config from my  2.4.20rc2 and from a 
> 2.2.20, where the NIC is working like a charm....
> 


I have the same ethernet card as you, but do not have any trouble.
Reading your config etc., I guess that your motherboard do not have a
good support for local IOAPIC.

You should definitely compile without SMP and without local IOAPIC.

Cheers,

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
