Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751781AbWIGOvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbWIGOvU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 10:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbWIGOvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 10:51:20 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:64395 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751781AbWIGOvT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 10:51:19 -0400
Message-ID: <450031E6.7010603@drzeus.cx>
Date: Thu, 07 Sep 2006 16:51:18 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [MMC] Fix SD timeout calculation
References: <20060618123432.15915.71389.stgit@poseidon.drzeus.cx> <20060907125840.GA6015@dyn-67.arm.linux.org.uk>
In-Reply-To: <20060907125840.GA6015@dyn-67.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Sun, Jun 18, 2006 at 02:34:37PM +0200, Pierre Ossman wrote:
>> Secure Digital cards use a different algorithm to calculate the timeout
>> for data transfers. Using the MMC one works often, but not always.
> 
> Applied, thanks.
> 
> I'm wondering about this cleanup though - both the timeout calculations
> appear to be identical, so making this a library function seems to be
> the right way to go... unless you know different?
> 

Shouldn't be a problem.

Acked-by: Pierre Ossman <drzeus@drzeus.cx>

