Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWEBHB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWEBHB3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 03:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWEBHB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 03:01:29 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:52440 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932423AbWEBHB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 03:01:28 -0400
Date: Tue, 2 May 2006 09:06:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
Message-ID: <20060502070618.GA10749@elte.hu>
References: <20060419112130.GA22648@elte.hu> <20060420091856.GB21660@wotan.suse.de> <20060421112049.GA5609@elte.hu> <20060421114501.GA22570@elte.hu> <20060501124942.GA21918@elte.hu> <p73aca07whs.fsf@bragg.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73aca07whs.fsf@bragg.suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> Ingo Molnar <mingo@elte.hu> writes:
> 
> > FYI, even on 2.6.17-rc3 i get the one below. v2.6.17 showstopper i 
> > guess?
> 
> Did you send a full boot log?

yes, in the previous mail, in the same thread. (maybe lkml ate it - it's 
an allyesconfig bootup so a large bootlog and a large config) I've also 
uploaded them to:

	http://redhat.com/~mingo/misc/

debug-pagealloc.patch is the debug patch i made based on Nick's earlier 
suggestions.

> If it's using ACPI NUMA try numa=noacpi - it might be some problem 
> with the node discovery on your machine.

this is a non-NUMA box (Athlon64 X2 desktop machine).

	Ingo
