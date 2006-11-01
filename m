Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992783AbWKATsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992783AbWKATsr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 14:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992782AbWKATsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 14:48:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63362 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992720AbWKATsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 14:48:46 -0500
Date: Wed, 1 Nov 2006 11:44:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
cc: Andi Kleen <ak@suse.de>, Ernst Herzberg <earny@net4u.de>,
       Len Brown <lenb@kernel.org>, Adrian Bunk <bunk@stusta.de>,
       Hugh Dickins <hugh@veritas.com>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, linux-pm@osdl.org,
       Martin Lorenz <martin@lorenz.eu.org>
Subject: Re: 2.6.19-rc <-> ThinkPads
In-Reply-To: <20061101193333.GC9085@mellanox.co.il>
Message-ID: <Pine.LNX.4.64.0611011141450.25218@g5.osdl.org>
References: <Pine.LNX.4.64.0611011003270.25218@g5.osdl.org>
 <20061101193333.GC9085@mellanox.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Nov 2006, Michael S. Tsirkin wrote:

> > I've pushed out the changes, but here is the part that may or may not 
> > matter for anybody who wants to test it if they don't use git or if it 
> > hasn't mirrored out yet. Michael? Martin?
> 
> I pulled the latest git, and seems to work for me, thanks.
> This still could be a false negative (happened already) so I'll
> continue using this, and will post the results.

Ok, thanks.

> > Somebody should look into that case. Does anybody feel like they want to 
> > learn more about the IO-APIC? Halloween is over and gone, but if you want 
> > to scare small children _next_ year, telling them about the IO-APIC is 
> > likely a good strategy.
> 
> Hmm, sounds interesting :)
> Is this a good place to start (I'm feeling lucky hit for IO-APIC)?
> http://www.intel.com/design/chipsets/datashts/290566.htm

Yeah, that's the datasheet. Note that a lot of the IO-APIC complexity is 
not so much in the programming interfaces themselves, but in keeping track 
of how the heck the thing is connected (ie ExtINT vs SCI vs "normal apic 
interrupt" etc).

		Linus
