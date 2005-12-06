Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbVLFU27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbVLFU27 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 15:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbVLFU27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 15:28:59 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:8932 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030227AbVLFU26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 15:28:58 -0500
Subject: Re: Add tainting for proprietary helper modules.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <4395F097.5060005@didntduck.org>
References: <20051203004102.GA2923@redhat.com>
	 <Pine.LNX.4.61.0512050832290.27133@chaos.analogic.com>
	 <20051205173041.GE12664@redhat.com>
	 <20051205093436.44d146e6@localhost.localdomain>
	 <1133899612.23610.59.camel@localhost.localdomain>
	 <4395F097.5060005@didntduck.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 06 Dec 2005 20:28:00 +0000
Message-Id: <1133900880.23610.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-12-06 at 15:12 -0500, Brian Gerst wrote:
> Alan Cox wrote:
> > On Llu, 2005-12-05 at 09:34 -0800, Stephen Hemminger wrote:
> > 
> >>IMHO ndiswrapper can't claim legitimately to be GPL, so just
> >>patch that. 
> > 
> > 
> > Actually it isnt so simple. Load ndiswrapper. Now load a GPL windows
> > driver binary. I don't know if ndiswrapper itself could dig licenses out
> > of windows modules but if so it could even conditionally taint.
> > 
> > Alan
> 
> On the other hand, if the windows driver were GPL then there wouldn't be 
> any barrier to writing a native driver.

Sure, but the point was to demonstrate in a clear and logical fashion
that ndiswrapper could be GPL.
