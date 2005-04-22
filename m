Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbVDVPsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbVDVPsG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 11:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVDVPsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 11:48:06 -0400
Received: from pimout4-ext.prodigy.net ([207.115.63.98]:29578 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261972AbVDVPsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 11:48:02 -0400
Date: Fri, 22 Apr 2005 08:47:55 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Harish K Harshan <harish@amritapuri.amrita.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i830 lockup
Message-ID: <20050422154755.GA2892@taniwha.stupidest.org>
References: <42225.203.197.150.195.1113980805.squirrel@mail.amrita.ac.in> <20050420065751.GA9791@taniwha.stupidest.org> <47196.203.197.150.195.1114171742.squirrel@mail.amrita.ac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47196.203.197.150.195.1114171742.squirrel@mail.amrita.ac.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2005 at 05:39:02PM +0530, Harish K Harshan wrote:

> But the system works pretty fine when other applications are
> running.

so either the driver is poking something that is causing problems or
maybe the card when operating makes the system unstabel

> Oncei load the driver, the system gets messed up. Could it be the
> problem with the way I handle DMA and interrupts??

maybe, but i would wouldn't think so

> I mean, is it possible to mess up everything by wrong programming???

yes

> This driver works prefectly on the other IPCs we have, but not on
> the two-piece board (Chino-Laxons) systems we have.

if these are embedded system they might have some weird wiring or
similar (embedded PCs used to have lots of strangeness to them, i
assume that hasn't changed)

> The DMA channels are both free before loading the drivers all the
> time, and one it is loaded, the /proc/dma file shows the DMA has
> been hooked properly. Could it still be the problem with the
> CPU/Cache/Chipset as you said?

i would ask the mainboard maker and also make sure you have the most
recent bios

also make sure your driver isn't stomping on bad memory in the slight
chance it whacking chipset registers I guess
