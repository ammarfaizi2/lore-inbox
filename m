Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWJQTnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWJQTnY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 15:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWJQTnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 15:43:23 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:4113 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751232AbWJQTnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 15:43:23 -0400
Date: Tue, 17 Oct 2006 15:43:22 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
cc: Greg K-H <greg@kroah.com>, Duncan Sands <duncan.sands@math.u-psud.fr>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 4/4] Driver core: Don't fail attaching the device if it
 cannot be bound.
In-Reply-To: <20061017182536.48c8cb91@gondolin.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0610171542440.3627-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2006, Cornelia Huck wrote:

> On Tue, 17 Oct 2006 12:04:28 -0400 (EDT),
> Alan Stern <stern@rowland.harvard.edu> wrote:

> > It looks odd to test the value of ret when you've just crashed the system 
> > if ret < 0.  You probably should change the BUG_ON to a WARN_ON or 
> > something similar.
> 
> OK, WARN_ON is probably better (but it should never happen anyway).
> Updated patch below.

Yes, I like this one better.

Alan Stern

