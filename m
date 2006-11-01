Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992695AbWKAR0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992695AbWKAR0A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 12:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992693AbWKAR0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 12:26:00 -0500
Received: from ns2.suse.de ([195.135.220.15]:24301 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1946951AbWKARZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 12:25:58 -0500
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.19-rc <-> ThinkPads
Date: Wed, 1 Nov 2006 18:25:47 +0100
User-Agent: KMail/1.9.5
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, Ernst Herzberg <earny@net4u.de>,
       Len Brown <lenb@kernel.org>, Adrian Bunk <bunk@stusta.de>,
       Hugh Dickins <hugh@veritas.com>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, linux-pm@osdl.org,
       Martin Lorenz <martin@lorenz.eu.org>
References: <Pine.LNX.4.64.0610312123320.25218@g5.osdl.org> <20061101055435.GB4933@mellanox.co.il> <Pine.LNX.4.64.0610312206390.25218@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610312206390.25218@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611011825.47710.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I suspect reverting it is the right thing to do - the patch only 
> introduces bugs, an doesn't actually _fix_ anything, it just "cleans 
> things up".

Ok please revert the i386 patch for now then if it fixes the ThinkPads. 
The x86-64 version should be probably fixed too, but doesn't cleanly. I will 
send you later a patch to fix this there properly.

-Andi
