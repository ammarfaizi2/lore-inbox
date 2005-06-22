Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbVFVQ4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVFVQ4S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 12:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVFVQ4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 12:56:08 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:31992 "EHLO
	godzilla.mvista.com") by vger.kernel.org with ESMTP id S261587AbVFVQxJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 12:53:09 -0400
Date: Wed, 22 Jun 2005 09:52:40 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: "Eugeny S. Mints" <emints@ru.mvista.com>,
       Andrew Lewis <andrew-lewis@netspace.net.au>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: ARM Linux Suitability for Real-time Application
In-Reply-To: <20050622100231.A28181@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10506220951190.455-100000@godzilla.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Jun 2005, Russell King wrote:

> If you're just after some background process to run off interrupts with
> minimal interrupt latency, the good news is that you don't have to modify
> the kernel on ARM, and you certainly don't need any RT patches.
> 
> If you use the FIQ, then your FIQ latency will be the time it takes the
> CPU to enter your FIQ function.  Since the kernel _never_ disables FIQs
> in any way, FIQs have ultimate priority over everything else in the
> system.
> 

Aren't FIQ's only on some ARM's ? 


Daniel

