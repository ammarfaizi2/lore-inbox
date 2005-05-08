Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263015AbVEHXxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbVEHXxj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 19:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263016AbVEHXxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 19:53:39 -0400
Received: from mail.suse.de ([195.135.220.2]:2221 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S263015AbVEHXxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 19:53:37 -0400
Date: Mon, 9 May 2005 01:53:29 +0200
From: Andi Kleen <ak@suse.de>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, zwane@arm.linux.org.uk,
       len.brown@intel.com, venkatesh.pallipadi@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] Do not enforce unique IO_APIC_ID for Xeon processors in EM64T mode (x86_64)
Message-ID: <20050508235329.GA27717@wotan.suse.de>
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04B51@USRV-EXCH4.na.uis.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04B51@USRV-EXCH4.na.uis.unisys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2005 at 12:28:26PM -0500, Protasevich, Natalie wrote:
> 
> > > Sure, I will remove the io_apic_get_unique_id() then. 
> > Perhaps, it will 
> > > be easy to put it back in if someone implements a chipset 
> > that needs it.
> > 
> > I did it myself now.
> >
> 
> Ok, great, I was about to put it together, but you beat me to it :) You
> probably don't need the "#define IO_APIC_MAX_ID		0xFE: line
> anymore?

Removed now, thanks.

-Andi
