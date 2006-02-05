Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWBESxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWBESxc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 13:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWBESxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 13:53:32 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59150 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751119AbWBESxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 13:53:32 -0500
Date: Sun, 5 Feb 2006 19:53:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Christoph Hellwig <hch@infradead.org>, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] x86_64: unexport ia32_sys_call_table
Message-ID: <20060205185330.GC15767@stusta.de>
References: <20060205182930.GA15767@stusta.de> <20060205184629.GA4791@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060205184629.GA4791@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2006 at 06:46:29PM +0000, Christoph Hellwig wrote:
> On Sun, Feb 05, 2006 at 07:29:30PM +0100, Adrian Bunk wrote:
> > This export doesn't seem to do anything but bloating the kernel by
> > a few bytes.
> 
> ACK. The native syscall table isn't exported, so the 32bit compat one
> shouldn't either - and afaik isn't on any other port.

It is also exported on sparc64 because the Solaris binary emulation uses 
it there.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

