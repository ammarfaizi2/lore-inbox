Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264181AbTICTow (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 15:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264116AbTICToq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 15:44:46 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:14603 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S264409AbTICTnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 15:43:19 -0400
Date: Wed, 3 Sep 2003 16:45:42 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
X-X-Sender: marcelo@logos.cnet
To: Sebastian Reichelt <SebastianR@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.4.21] orinoco_cs card reinsertion
In-Reply-To: <20030903213644.1a56a7f2.SebastianR@gmx.de>
Message-ID: <Pine.LNX.4.44.0309031643400.6102-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Sep 2003, Sebastian Reichelt wrote:

> > Can you please try 2.4.22? It contains orinoco changes including in
> > the area you changed. 
> 
> Sorry, 2.4.22 (from kernel.org) just hangs when I insert the card, after
> the first of two beeps. Ctrl-Alt-Del doesn't work. No messages are
> printed except the usual "cs: memory probe 0xa0000000-0xa0ffffff:
> clean.", and syslog doesn't seem to have been flushed (it's cut off at
> a higher position).
> 
> One thing I noticed from syslog is that the socket is assigned another
> IRQ: 5 instead of 9.

Hum, are you using ACPI? There have a few IRQ assignment issues reported 
with the new ACPI in 2.4.22.

Can you please try booting with "pci=noacpi" option ? 


