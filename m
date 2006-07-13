Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbWGMMRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbWGMMRP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 08:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbWGMMRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 08:17:15 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:29312 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1750982AbWGMMRO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 08:17:14 -0400
Message-ID: <44B639D0.4040903@drzeus.cx>
Date: Thu, 13 Jul 2006 14:17:20 +0200
From: Pierre Ossman <drzeus@drzeus.cx>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Change SDHCI version error to a warning
References: <20060711190710.12686.11805.stgit@poseidon.drzeus.cx> <20060713121328.GA8376@flint.arm.linux.org.uk>
In-Reply-To: <20060713121328.GA8376@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Tue, Jul 11, 2006 at 09:07:10PM +0200, Pierre Ossman wrote:
>> O2 Micro's controllers have a larger specification version value and are
>> therefore denied by the driver. When bypassing this check they seem to work
>> fine. This patch makes the code a bit more forgiving by changing the
>> warning to an error.
> 
> Doesn't this patch change the error to a warning instead?

*doh*

Must have been late when I wrote the commit message. It should of course
be a change from an error to a warning in order to just nag users
instead of completely blocking them.

Rgds
Pierre

