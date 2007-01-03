Return-Path: <linux-kernel-owner+w=401wt.eu-S1754276AbXACEev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754276AbXACEev (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 23:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754266AbXACEev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 23:34:51 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:48985
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754169AbXACEeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 23:34:50 -0500
Date: Tue, 02 Jan 2007 20:34:48 -0800 (PST)
Message-Id: <20070102.203448.88476383.davem@davemloft.net>
To: segher@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, devel@laptop.org, jengelh@linux01.gwdg.de,
       benh@kernel.crashing.org, wmb@firmworks.com, jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: David Miller <davem@davemloft.net>
In-Reply-To: <3676953abedcbe6d86da74a4997593cb@kernel.crashing.org>
References: <978466dd510f659cd69b67ee7309be28@kernel.crashing.org>
	<20070102.140749.104035927.davem@davemloft.net>
	<3676953abedcbe6d86da74a4997593cb@kernel.crashing.org>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Wed, 3 Jan 2007 01:52:06 +0100

> >> Leaving aside the issue of in-memory or not, I don't think
> >> it is realistic to think any completely common implementation
> >> will work for this -- it might for current SPARC+PowerPC+OLPC,
> >> but more stuff will be added over time...
> >
> > I see nothing supporting this IMHO bogus claim.
> 
> Please keep in mind that not all systems want to kill OF
> as soon as they enter the kernel -- some want to keep it
> active basically forever (or only remove it when the user
> asks for it).

That's what we do on sparc32 and sparc64, I of course understand this.
