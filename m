Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263076AbVAFWqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263076AbVAFWqP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 17:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263059AbVAFWqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 17:46:15 -0500
Received: from main.gmane.org ([80.91.229.2]:9625 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261178AbVAFWps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 17:45:48 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andrey Melnikoff <temnota+news@kmv.ru>
Subject: Re: Questions about the CMD640 and RZ1000 bugfix support options
Date: Fri, 7 Jan 2005 01:40:49 +0300
Message-ID: <hcr0b2-ofr.ln1@kenga.kmv.ru>
References: <41D5D206.1040107@mathematica.scientia.net> <1104676209.15004.58.camel@localhost.localdomain> <e0qta2-7jr.ln1@kenga.kmv.ru> <1105025417.17176.222.camel@localhost.localdomain>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: kenga.kmv.ru
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.6-rc1 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Mer, 2005-01-05 at 18:58, Andrey Melnikoff wrote:
> > > > At least the second of those two seems to cause some little slowdown 
> > > > ("This may slow disk throughput by a few percent, but at least things 
> > > They only trigger for the affected chipsets
> > But enabled by default. Maybe disable it by default ? Or make depend with 
> > CONFIG_M586 || CONFIG_M586TSC || CONFIG_M586MMX ?

> They should be enabled by default. 
Why? This is really _OLD_ and _BUGGY_ chips. As I see in google - it used 
in Asustek Pentium MB PCI/I-P54SP4 and some Intel mb for Pentium with
Neptune chipsets. All of this MB - for classic Pentium 75/90/100MHz. 

> That makes it safer for default compiles, and their code size is 
> close to if not nil because it can all be __devinit or __init
At this time, no modern MB use this buggy chipsets.

