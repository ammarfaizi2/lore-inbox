Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262594AbULPBbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbULPBbx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 20:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbULPB3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 20:29:04 -0500
Received: from gprs215-43.eurotel.cz ([160.218.215.43]:48258 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262594AbULPB1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 20:27:09 -0500
Date: Thu, 16 Dec 2004 02:26:27 +0100
From: Pavel Machek <pavel@suse.cz>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: Andi Kleen <ak@suse.de>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk
Subject: Re: arch/xen is a bad idea
Message-ID: <20041216012627.GA6462@elf.ucw.cz>
References: <20041215114916.GB1232@elf.ucw.cz> <E1CekDZ-0005ZY-00@mta1.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CekDZ-0005ZY-00@mta1.cl.cam.ac.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > BTW if you merge xen as separate architecture, it will be *very* hard
> > to merge it back to i386. That patch would be huge, and would need to
> > go in "atomically".
> 
> I don't see it like that. While continuing to track changes in
> i386/x86_64, we'd restructure the code under arch xen such that
> it could build (or even boot) time switch between running native
> and over Xen. At some point the arch directory could then be
> renamed.  This would be a big project, and one that would involve
> a lot more people than just the Xen team. Because the x86

So you plan to

merge arch/xen

then modify arch/xen to do all arch/i386 can do

then rm -rf arch/i386, mv arch/xen arch/i386? Well, I'd say that's
rather ambitious plan....
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
