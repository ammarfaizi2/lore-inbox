Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbTIKQmN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 12:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbTIKQmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 12:42:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26038 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261393AbTIKQmK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 12:42:10 -0400
Date: Thu, 11 Sep 2003 17:42:10 +0100
From: Matthew Wilcox <willy@debian.org>
To: Andi Kleen <ak@suse.de>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: Memory mapped IO vs Port IO
Message-ID: <20030911164210.GM21596@parcelfarce.linux.theplanet.co.uk>
References: <20030911160116.GI21596@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel> <p73oexri9kx.fsf@oldwotan.suse.de> <20030911162504.GL21596@parcelfarce.linux.theplanet.co.uk> <20030911183136.01dfeb53.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911183136.01dfeb53.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 06:31:36PM +0200, Andi Kleen wrote:
> On Thu, 11 Sep 2003 17:25:04 +0100
> Matthew Wilcox <willy@debian.org> wrote:
> > That's not true for MMIO writes which are posted.  They should take
> > no longer than a memory write.  For MMIO reads and PIO reads & writes,
> > you are, of course, correct.
> 
> Even a memory write is tens to hundres of cycles.

So are mispredicted branches.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
