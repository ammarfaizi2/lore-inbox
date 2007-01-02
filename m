Return-Path: <linux-kernel-owner+w=401wt.eu-S1755261AbXABFKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755261AbXABFKt (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 00:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755266AbXABFKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 00:10:49 -0500
Received: from gate.crashing.org ([63.228.1.57]:44369 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755261AbXABFKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 00:10:48 -0500
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Cc: segher@kernel.crashing.org, hch@infradead.org,
       linux-kernel@vger.kernel.org, devel@laptop.org, dmk@flex.com,
       wmb@firmworks.com, jg@laptop.org
In-Reply-To: <20070101.210108.41636312.davem@davemloft.net>
References: <1167710760.6165.32.camel@localhost.localdomain>
	 <20070101.203043.112622209.davem@davemloft.net>
	 <1167713825.6165.54.camel@localhost.localdomain>
	 <20070101.210108.41636312.davem@davemloft.net>
Content-Type: text/plain
Date: Tue, 02 Jan 2007 16:09:14 +1100
Message-Id: <1167714554.6165.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-01 at 21:01 -0800, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Tue, 02 Jan 2007 15:57:05 +1100
> 
> > I like being able to have a simple way (ie. tar /proc/device-tree) to
> > tell user to send me their DT and have in the end an exact binary
> > representation so I can actually dig for problems, like a wrong phandle
> > in an interrupt-map or stuff like that...
> 
> "prtconf -pv" is what I'd ask the user to do on Sparc, or something
> similar.
> 
> In over 10 years of the sparc port there's never been a situation
> where "prtconf -pv" or similar did not get me the information I
> needed. :-)
> 
> "prtconf" walks the device tree raw using /dev/openprom and
> pretty prints it like I assume your ppc "lsprop" thing does.

Probably. The question now is that if we want to somewhat converge, what
to do... either change sparc habits or change powerpc habits :-) I'll
let that fight happen between you and paulus and watch while having a
beer at LCA though :-)

Ben.


