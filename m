Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbVKPQSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbVKPQSQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 11:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbVKPQSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 11:18:16 -0500
Received: from ns.suse.de ([195.135.220.2]:38622 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750836AbVKPQSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 11:18:15 -0500
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Wed, 16 Nov 2005 17:10:04 +0100
User-Agent: KMail/1.8.2
Cc: Oliver Neukum <oliver@neukum.org>, jmerkey <jmerkey@utah-nac.org>,
       =?utf-8?q?J=C3=B6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       alex14641@yahoo.com, linux-kernel@vger.kernel.org
References: <20051116005034.73421.qmail@web50210.mail.yahoo.com> <200511161630.59588.oliver@neukum.org> <1132155482.2834.42.camel@laptopd505.fenrus.org>
In-Reply-To: <1132155482.2834.42.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511161710.05526.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 November 2005 16:38, Arjan van de Ven wrote:
> On Wed, 2005-11-16 at 16:30 +0100, Oliver Neukum wrote:
> > Am Mittwoch, 16. November 2005 15:42 schrieb jmerkey:
> > > Map a blank ro page beneath the address range when stack memory is 
> > > mapped is trap on page faults to the page when folks go off the end of 
> > > th e stack.
> > > 
> > > Easy to find.
> > 
> > Provided you can easily trigger it. I don't see how that is a given.
> 
> the same is true for a unified 8k stack or for the 4k/4k split though.
> Ok sure there's a 1.5Kb difference on the one side.. (but a 2Kb gain on
> the other side)

I was always in favour of 8K process stacks + irq stacks. Works great on x86-64.

-Andi
