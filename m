Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264844AbTFTVkm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 17:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264884AbTFTVkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 17:40:42 -0400
Received: from fe5.rdc-kc.rr.com ([24.94.163.52]:49673 "EHLO mail5.kc.rr.com")
	by vger.kernel.org with ESMTP id S264844AbTFTVkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 17:40:37 -0400
Date: Fri, 20 Jun 2003 16:54:37 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: Matti Rendahl <matti@comedialabs.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: memory problem with 2.4.21 SMP on Dell Dimension 8300 (i875p chipset)
Message-ID: <20030620215437.GB14880@glitch.localdomain>
Mail-Followup-To: Matti Rendahl <matti@comedialabs.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20030616021059.GA1671@glitch.localdomain> <20030620012411.GA1532@glitch.localdomain> <1056092485.9391.41.camel@comedialabs.dyndns.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1056092485.9391.41.camel@comedialabs.dyndns.info>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 09:01:25AM +0200, Matti Rendahl wrote:
> This is something related to/triggered by the ACPI code, booting with
> acpi=off makes it go away (2.4.21). 

I was starting to suspect ACPI, but hadn't yet verified this. 
Unfortunately I need ACPI in order to enable hyperthreading, so I guess
it's time to check out the current patches.  Thanx for the info!
