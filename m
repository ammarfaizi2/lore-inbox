Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992691AbWKARZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992691AbWKARZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 12:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946953AbWKARZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 12:25:58 -0500
Received: from ns1.suse.de ([195.135.220.2]:32927 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1946942AbWKARZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 12:25:57 -0500
From: Andi Kleen <ak@suse.de>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: 2.6.19-rc <-> ThinkPads
Date: Wed, 1 Nov 2006 18:17:54 +0100
User-Agent: KMail/1.9.5
Cc: Linus Torvalds <torvalds@osdl.org>, Ernst Herzberg <earny@net4u.de>,
       Len Brown <lenb@kernel.org>, Adrian Bunk <bunk@stusta.de>,
       Hugh Dickins <hugh@veritas.com>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, linux-pm@osdl.org,
       Martin Lorenz <martin@lorenz.eu.org>
References: <Pine.LNX.4.64.0610312123320.25218@g5.osdl.org> <20061101055435.GB4933@mellanox.co.il> <20061101061857.GC4933@mellanox.co.il>
In-Reply-To: <20061101061857.GC4933@mellanox.co.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611011817.55024.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 November 2006 07:18, Michael S. Tsirkin wrote:
> Quoting r. Michael S. Tsirkin <mst@mellanox.co.il>:
> > What I plan to do is using eea0e11c1f0d6ef89e64182b2f1223a4ca2b74a2
> > for a couple of days and see how this works out.
> 
> Ugh. Unfortunately in that kernel version, the e1000 driver says
> the eeprom checksum is bad (works fine with 2.6.19-rc3).
> So, I tried some suspends/resumes and things seem to work, but
> I won't be able to test it under real use conditions.
> 
> But maybe its another red herring?
> Andi, could you maybe look at that commit and tell me whether
> it could cause troubles with ACPI after suspend/resume even
> theoretically?

It touches suspend/resume so it could break something theoretically.

-Andi
