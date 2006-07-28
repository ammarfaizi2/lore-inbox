Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752059AbWG1Svw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbWG1Svw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 14:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbWG1Svw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 14:51:52 -0400
Received: from mail.suse.de ([195.135.220.2]:13733 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752059AbWG1Svw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 14:51:52 -0400
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch 1/5] Add comments to the PDA structure to annotate offsets
Date: Fri, 28 Jul 2006 20:52:20 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <1154102546.6416.9.camel@laptopd505.fenrus.org> <200607282041.38506.ak@suse.de> <1154112207.6416.44.camel@laptopd505.fenrus.org>
In-Reply-To: <1154112207.6416.44.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607282052.20559.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 July 2006 20:43, Arjan van de Ven wrote:
> On Fri, 2006-07-28 at 20:41 +0200, Andi Kleen wrote:
> > On Friday 28 July 2006 18:03, Arjan van de Ven wrote:
> > > Subject: [patch 1/5] Add comments to the PDA structure to annotate
> > > offsets From: Arjan van de Ven <arjan@linux.intel.com>
> >
> > So why exactly do you think these numbers need to be documented?
> >
> > If there is a reason there should be a comment in the code.
> >
> > Nobody should use fixed numbers, but always get the current ones
> > from asm-offset
>
> the 40 one is a gcc ABI one (same offset as userland); 

Ah sounds ugly. Wasn't it possible to pass that as an option
to gcc?

> that is 
> documented in the later patch

I still hate the numbers. Perhaps do them only before your canary.
Also you should have a BUILD_BUG_ON() for this somewhere

-Andi
