Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbWFUBeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWFUBeQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 21:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751920AbWFUBeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 21:34:16 -0400
Received: from gate.crashing.org ([63.228.1.57]:46031 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751919AbWFUBeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 21:34:15 -0400
Subject: Re: [patch 0/3] 2.6.17 radix-tree: updates and lockless
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, npiggin@suse.de, Paul.McKenney@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.64.0606201806350.14643@schroedinger.engr.sgi.com>
References: <20060408134635.22479.79269.sendpatchset@linux.site>
	 <20060620153555.0bd61e7b.akpm@osdl.org>
	 <1150844989.1901.52.camel@localhost.localdomain>
	 <20060620163037.6ff2c8e7.akpm@osdl.org>
	 <1150847428.1901.60.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606201732580.14331@schroedinger.engr.sgi.com>
	 <1150850849.12507.10.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606201806350.14643@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 11:33:49 +1000
Message-Id: <1150853629.12507.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 18:07 -0700, Christoph Lameter wrote:
> On Wed, 21 Jun 2006, Benjamin Herrenschmidt wrote:
> 
> > No, our hardware interrupt numbers are an encoded form containing the
> > geographical location of the device :) so they are 24 bits at least (and
> > we have a platform coming where they can be 64 bits).
> 
> PICs with build in GPSses? And I thought we had weird hardware....

hehehe :) Well, domain/bus/slot number if you prefer but yeah, a GPS
would be much more cool !

Ben.


