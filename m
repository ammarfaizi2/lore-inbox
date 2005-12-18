Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965204AbVLRP7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965204AbVLRP7h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 10:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965210AbVLRP7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 10:59:36 -0500
Received: from sccrmhc13.comcast.net ([63.240.77.83]:10135 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S965204AbVLRP7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 10:59:36 -0500
In-Reply-To: <20051218155108.GF23349@stusta.de>
References: <20051215140013.7d4ffd5b.akpm@osdl.org> <20051216141002.2b54e87d.diegocg@gmail.com> <20051216140425.GY23349@stusta.de> <20051216163503.289d491e.diegocg@gmail.com> <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com> <p73slsrehzs.fsf@verdi.suse.de> <20051217205238.GR23349@stusta.de> <61D4A300-4967-4DC1-AD2C-765A3D2D9743@comcast.net> <20051218054323.GF23384@wotan.suse.de> <5DB2F520-5666-4C7F-9065-51117A0F54B9@comcast.net> <20051218155108.GF23349@stusta.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F0C141FB-3596-42F2-B359-457C414170FC@comcast.net>
Cc: Andi Kleen <ak@suse.de>, Kyle Moffett <mrmacman_g4@mac.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Content-Transfer-Encoding: 7bit
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Sun, 18 Dec 2005 10:59:22 -0500
To: Adrian Bunk <bunk@stusta.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 18, 2005, at 10:51 AM, Adrian Bunk wrote:

> Is this just FUD or can you give an example where this is a real
> problem that can't be solved by using kmalloc()?

Can you prove "Under all uses, circumstances and code requirements we  
will do fine with 4K stacks today and tomorrow" ? How will deeply  
nested function calls, longer call chains etc. be solved by kmalloc()?

> Therefore, your point it would make code much more complex sounds
> strange.

My point wasn't that reducing stack will make code much more complex.  
My point was some type of functionality might validly require complex  
code which requires more stack - there are capable and affordable  
machines to solve such problems and all we are doing with 4kB stacks  
is that preventing it.

Again - what is the pressing need to remove the "8Kb Stack _Option_"?  
What problem does it solve on 64 bit arches?

Parag

