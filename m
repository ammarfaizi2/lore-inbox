Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262959AbVALANf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262959AbVALANf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 19:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262977AbVALAJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 19:09:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:3226 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262960AbVALAHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 19:07:21 -0500
Date: Tue, 11 Jan 2005 16:07:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Re: flush_cache_page()
In-Reply-To: <20050111223652.D30946@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0501111605570.2373@ppc970.osdl.org>
References: <20050111223652.D30946@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 11 Jan 2005, Russell King wrote:
>
> Any responses on this?  Didn't get any last time I mailed this out.

I don't have any real objections. I'd like it verified that gcc can
compile away all the overhead on the architectures that don't use the pfn, 
since "page_to_pfn()" can be a bit expensive otherwise.. But I don't see 
anything wrong with the approach.

		Linus
