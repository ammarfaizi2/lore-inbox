Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTFTGtm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 02:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTFTGtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 02:49:42 -0400
Received: from smaug.dreamhost.com ([66.33.209.15]:37033 "EHLO
	smaug.dreamhost.com") by vger.kernel.org with ESMTP id S261874AbTFTGtl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 02:49:41 -0400
Subject: Re: memory problem with 2.4.21 SMP on Dell Dimension 8300 (i875p
	chipset)
From: Matti Rendahl <matti@comedialabs.com>
To: Greg Norris <haphazard@kc.rr.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030620012411.GA1532@glitch.localdomain>
References: <20030616021059.GA1671@glitch.localdomain>
	 <20030620012411.GA1532@glitch.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1056092485.9391.41.camel@comedialabs.dyndns.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 20 Jun 2003 09:01:25 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-20 at 03:24, Greg Norris wrote:
> I still haven't figured this one out, but for whatever it's worth
> 2.5.72 doesn't appear to trigger the problem.  Guess I won't worry
> about it too much. ;-)
> 
> On Sun, Jun 15, 2003 at 09:10:59PM -0500, Greg Norris wrote:
> > After running a SMP 2.4.21 kernel on my Dell Dimension 8300, the BIOS
> > thinks that the amount of memory has changed.  When the box is
> > rebooted, I get the following message at the end of BIOS
> > initialization:
> > 
> >    The amount of system memory has changed.
> >    Alert! OS Install Mode enabled. Amount of available memory limited to 256MB.
> > 

This is something related to/triggered by the ACPI code, booting with
acpi=off makes it go away (2.4.21). 

--matti


