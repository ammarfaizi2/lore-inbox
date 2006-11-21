Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031354AbWKUTrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031354AbWKUTrg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 14:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031356AbWKUTrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 14:47:36 -0500
Received: from ns1.suse.de ([195.135.220.2]:29152 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1031354AbWKUTrf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 14:47:35 -0500
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6.19 patch] i386/x86_64: remove the unused EXPORT_SYMBOL(dump_trace)
Date: Tue, 21 Nov 2006 20:47:30 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <20061121194138.GF5200@stusta.de>
In-Reply-To: <20061121194138.GF5200@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611212047.30192.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 November 2006 20:41, Adrian Bunk wrote:
> This patch removes the unused EXPORT_SYMBOL(dump_trace) added on i386 
> and x86_64 in 2.6.19-rc.
> 
> By removing them before the final 2.6.19 we avoid the possibility of 
> people later whining that we removed exports they started using.

I exported it for systemtap so that they can stop using the broken
hack they currently use as unwinder.

-Andi
