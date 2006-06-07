Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWFGUgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWFGUgc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 16:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWFGUgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 16:36:32 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:57740 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1750868AbWFGUgc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 16:36:32 -0400
Message-ID: <448738CD.8030907@drzeus.cx>
Date: Wed, 07 Jun 2006 22:36:29 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Matt Reimer <mattjreimer@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2GB MMC/SD cards
References: <447AFE7A.3070401@drzeus.cx> <20060603141548.GA31182@flint.arm.linux.org.uk> <f383264b0606031140l2051a2d7p6a9b2890a6063aef@mail.gmail.com> <4481FB80.40709@drzeus.cx> <4484B5AE.8060404@drzeus.cx> <44869794.9080906@drzeus.cx> <20060607165837.GE13165@flint.arm.linux.org.uk>
In-Reply-To: <20060607165837.GE13165@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> I wonder if all 2GB cards are >= v4.2 of the spec?  If so, we could
> do what would appear correct to both the spec and reality, and select
> 512 byte blocksizes irrespective if they conform to v4.2 or later.
>
>   

This might only be a clarification as earlier specs apparently states
that all cards must have the block size set to 512 bytes at init.

As people seem to have been running their own hacks without any
problems, we probably should just change it and see if there's any
fallout. Live dangerous for a bit. ;)

Rgds
Pierre

