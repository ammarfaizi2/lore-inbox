Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWFQFGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWFQFGi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 01:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWFQFGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 01:06:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16048 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750814AbWFQFGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 01:06:37 -0400
Date: Sat, 17 Jun 2006 00:46:25 -0400
From: Dave Jones <davej@redhat.com>
To: Ian Kent <raven@themaw.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: AGPGART: unable to get memory for graphics translation table.
Message-ID: <20060617044625.GA8328@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ian Kent <raven@themaw.net>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0606171125390.2748@raven.themaw.net> <20060617034633.GC2893@redhat.com> <Pine.LNX.4.64.0606171201280.2812@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606171201280.2812@raven.themaw.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2006 at 12:02:30PM +0800, Ian Kent wrote:

 > >  > I've been having trouble with my Radeon card not working with X.
 > >  > 
 > >  > 01:00.0 VGA compatible controller: ATI Technologies Inc RV350 AS [Radeon 
 > >  > 9550]
 > >  > 
 > >  > The only thing I can find that may be a clue is:
 > >  > 
 > >  > Jun 17 11:12:48 raven kernel: agpgart: Detected AGP bridge 0
 > >  > Jun 17 11:12:48 raven kernel: agpgart: unable to get memory for graphics 
 > >  > translation table.
 > >  > Jun 17 11:12:48 raven kernel: agpgart: agp_backend_initialize() failed.
 > >  > Jun 17 11:12:48 raven kernel: agpgart-amd64: probe of 0000:00:00.0 failed 
 > >  > with error -12
 > >  
 > > Is this with the free Xorg drivers, or the ATI fglx thing ?
 > > I don't think I've ever seen agp_generic_create_gatt_table() fail before,
 > > and that hasn't changed for a looong time.
 > 
 > xorg driver yep.

Bizarre, I have no ideas.

full dmesg ? lspci ?
This is running 64 bit mode or 32 ?

		Dave


-- 
http://www.codemonkey.org.uk
