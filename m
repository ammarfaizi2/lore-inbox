Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262440AbUKQRKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbUKQRKZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 12:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbUKQRFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 12:05:16 -0500
Received: from fsmlabs.com ([168.103.115.128]:12941 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262439AbUKQRDR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 12:03:17 -0500
Date: Wed, 17 Nov 2004 10:03:00 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andi Kleen <ak@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Intel thermal monitor for x86_64
In-Reply-To: <20041115090156.GC1662@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0411171001550.3941@musoma.fsmlabs.com>
References: <Pine.LNX.4.61.0411130629190.3062@musoma.fsmlabs.com>
 <20041114081649.GA16795@wotan.suse.de> <Pine.LNX.4.61.0411141801320.3754@musoma.fsmlabs.com>
 <20041115090156.GC1662@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2004, Andi Kleen wrote:

> No, I was just worried about the locking issues.  Ok it was my mistake
> then I assume you used an NMI LVT setup. Without NMI using printk
> is fine and simpler. Can you change it to do that directly? 
> 
> Putting events additionally into mcelog would be still nice though.
> 
> > > Also can you at least additionally log an synthetic event using mce_log() ?
> > > This way someone collecting these log entries centrally get its it 
> > > all in the same log file. 
> > 
> > Ok, then i think we need to make the mce logging capable of storing 
> > extended information, is the code i did for i386 ok with you?
> 
> No, see my other mail for that.
> 
> for the thermtrips I would just redefine some fields and invent 
> a magic high bank number.

Thanks for the input Andi, i'll rework the patch.

	Zwane
