Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUFTTtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUFTTtf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 15:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbUFTTtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 15:49:35 -0400
Received: from cantor.suse.de ([195.135.220.2]:19111 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263795AbUFTTtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 15:49:33 -0400
Date: Sun, 20 Jun 2004 23:49:59 +0200
From: Andi Kleen <ak@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, rjwysocki@sisk.pl
Subject: Re: Opteron bug
Message-Id: <20040620234959.667ef8a2.ak@suse.de>
In-Reply-To: <40D58C2F.3010508@colorfullife.com>
References: <40D58C2F.3010508@colorfullife.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jun 2004 15:07:59 +0200
Manfred Spraul <manfred@colorfullife.com> wrote:

> Andi wrote:
> 
> >The kernel never uses backwards REP prefixes.
> >  
> >
> Huh? memmove uses backwards rep movsb on x86-64, at least in 2.6.5:

Hmm, you're right. I forgot that. Ok, I will change it, although
it's unlikely to be a real problem.
 
> But the bug appears to be so rare that it shouldn't matter - lets wait 
> for the microcode update. Btw, is there a runtime microcode updater for 
> Opteron cpus, similar to the Intel microcode driver?

AMD seems to only release microcode updates to BIOS vendors.

-Andi
 
