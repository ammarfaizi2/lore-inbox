Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422745AbWBIKO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422745AbWBIKO0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 05:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422749AbWBIKO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 05:14:26 -0500
Received: from ns.suse.de ([195.135.220.2]:40374 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422745AbWBIKO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 05:14:26 -0500
From: Andi Kleen <ak@suse.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH] early_printk: cleanup trailiing whitespace
Date: Thu, 9 Feb 2006 11:04:24 +0100
User-Agent: KMail/1.8.2
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
References: <20060208223959.5052de3b.rdunlap@xenotime.net>
In-Reply-To: <20060208223959.5052de3b.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602091104.24409.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 February 2006 07:39, Randy.Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Remove all trailing tabs and spaces.  No other changes.

I'm following Andrew's strategy. Everytime I submit a patch all
the trailing white spaces are removed. This means they will slowly
disappear. If they don't this means this code is not changing
and stable and then it doesn't matter anyways.

But big patches like this are not a good idea because they
just cause patch rejects and trouble.

-Andi

