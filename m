Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946633AbWKAGTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946633AbWKAGTO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 01:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946632AbWKAGTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 01:19:13 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:54930 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1946630AbWKAGTH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 01:19:07 -0500
Date: Wed, 1 Nov 2006 08:18:57 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ernst Herzberg <earny@net4u.de>, Len Brown <lenb@kernel.org>,
       Adrian Bunk <bunk@stusta.de>, Hugh Dickins <hugh@veritas.com>,
       Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, linux-pm@osdl.org,
       Martin Lorenz <martin@lorenz.eu.org>, Andi Kleen <ak@suse.de>
Subject: Re: 2.6.19-rc <-> ThinkPads
Message-ID: <20061101061857.GC4933@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <Pine.LNX.4.64.0610312123320.25218@g5.osdl.org> <20061101055435.GB4933@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101055435.GB4933@mellanox.co.il>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Michael S. Tsirkin <mst@mellanox.co.il>:
> What I plan to do is using eea0e11c1f0d6ef89e64182b2f1223a4ca2b74a2
> for a couple of days and see how this works out.

Ugh. Unfortunately in that kernel version, the e1000 driver says
the eeprom checksum is bad (works fine with 2.6.19-rc3).
So, I tried some suspends/resumes and things seem to work, but
I won't be able to test it under real use conditions.

But maybe its another red herring?
Andi, could you maybe look at that commit and tell me whether
it could cause troubles with ACPI after suspend/resume even
theoretically?

-- 
MST
