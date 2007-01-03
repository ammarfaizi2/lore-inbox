Return-Path: <linux-kernel-owner+w=401wt.eu-S1754264AbXACEfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754264AbXACEfs (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 23:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754266AbXACEfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 23:35:48 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:48991
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754244AbXACEfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 23:35:47 -0500
Date: Tue, 02 Jan 2007 20:35:46 -0800 (PST)
Message-Id: <20070102.203546.23014973.davem@davemloft.net>
To: segher@kernel.crashing.org
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org, devel@laptop.org,
       jengelh@linux01.gwdg.de, wmb@firmworks.com, jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: David Miller <davem@davemloft.net>
In-Reply-To: <12528f3f1e79ab0f1800b835f98f2a34@kernel.crashing.org>
References: <cdda01a9b094a86b24d8d192336f41e2@kernel.crashing.org>
	<1167785089.6165.95.camel@localhost.localdomain>
	<12528f3f1e79ab0f1800b835f98f2a34@kernel.crashing.org>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Wed, 3 Jan 2007 02:14:34 +0100

> [snipping a bit for now]
> 
> > and then, "fix"
> > that so that it works on x86 :-)
> 
> That works, if the goal is to just add x86/OLPC to the list of
> platforms that have a device tree fs.  I thought the plan was
> to create a single, more generic, OF interface/API in the kernel
> though.

Absolutely.

But let's get the first-order issue solved so the OLPC people
can get the functionality they need.  That's the most practical
approach.

