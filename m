Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262448AbVA0JKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbVA0JKt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 04:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbVA0JKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 04:10:49 -0500
Received: from isilmar.linta.de ([213.239.214.66]:36225 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S262448AbVA0JKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 04:10:45 -0500
Date: Thu, 27 Jan 2005 10:10:44 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Emmanuel Fleury <fleury@cs.aau.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.10] PCMCIA/CardBus Wifi Card Problem
Message-ID: <20050127091044.GA8724@debian>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	Emmanuel Fleury <fleury@cs.aau.dk>, linux-kernel@vger.kernel.org
References: <41F83795.7020408@cs.aau.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F83795.7020408@cs.aau.dk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 27, 2005 at 01:36:37AM +0100, Emmanuel Fleury wrote:
> Module                  Size  Used by
> orinoco_cs              9000  1
> orinoco                41324  1 orinoco_cs
> hermes                  8896  2 orinoco_cs,orinoco


> CONFIG_PCCARD=y
> # CONFIG_PCMCIA_DEBUG is not set
> # CONFIG_PCMCIA_OBSOLETE is not set
> # CONFIG_PCMCIA is not set

CONFIG_PCMCIA needs to be set to "y" or "m", and then you need to enable the
appropriate config options for orinoco PCMCIA cards.

Oh, and it doesn't seem to be a CardBus card (32-bit) but to be a 16-bit
PCMCIA card.

	Dominik
