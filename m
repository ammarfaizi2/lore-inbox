Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVAWCp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVAWCp6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 21:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVAWCp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 21:45:58 -0500
Received: from waste.org ([216.27.176.166]:650 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261180AbVAWCpy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 21:45:54 -0500
Date: Sat, 22 Jan 2005 18:45:38 -0800
From: Matt Mackall <mpm@selenic.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/12] random pt4: Create new rol32/ror32 bitops
Message-ID: <20050123024538.GR12076@waste.org>
References: <200501222113_MC3-1-940A-5393@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501222113_MC3-1-940A-5393@compuserve.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22, 2005 at 09:10:40PM -0500, Chuck Ebbert wrote:
> On Fri, 21 Jan 2005 at 15:41:06 -0600 Matt Mackall wrote:
> 
> > Add rol32 and ror32 bitops to bitops.h
> 
> Can you test this patch on top of yours?  I did it on 2.6.10-ac10 but it
> should apply OK.  Compile tested and booted, but only random.c is using it
> in my kernel.

If I recall correctly from my testing of this about a year ago,
compilers were already generating the appropriate rol/ror
instructions. Have you checked the disassembly and found it wanting?

-- 
Mathematics is the supreme nostalgia of our time.
