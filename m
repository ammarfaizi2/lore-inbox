Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbVLPOOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbVLPOOi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 09:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbVLPOOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 09:14:38 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:35257 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932265AbVLPOOh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 09:14:37 -0500
Subject: Re: [PATCH] ia64: disable preemption in udelay()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: hawkes@sgi.com, Tony Luck <tony.luck@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jack Steiner <steiner@sgi.com>,
       Keith Owens <kaos@sgi.com>, Dimitri Sivanich <sivanich@sgi.com>
In-Reply-To: <20051216010440.GA9886@agluck-lia64.sc.intel.com>
References: <20051214232526.9039.15753.sendpatchset@tomahawk.engr.sgi.com>
	 <20051215225040.GA9086@agluck-lia64.sc.intel.com>
	 <20051216010440.GA9886@agluck-lia64.sc.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 16 Dec 2005 14:14:28 +0000
Message-Id: <1134742468.28761.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-12-15 at 17:04 -0800, Luck, Tony wrote:
> Being out-of-line would reduce accuracy, but this would only be
> significant when the sleep is for a very small number of microseconds.

Even then its a predicted branch to code that will probably be in cache
so really ought to have no material impact.


