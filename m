Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314225AbSEBBqX>; Wed, 1 May 2002 21:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314227AbSEBBqW>; Wed, 1 May 2002 21:46:22 -0400
Received: from holomorphy.com ([66.224.33.161]:25556 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314225AbSEBBqV>;
	Wed, 1 May 2002 21:46:21 -0400
Date: Wed, 1 May 2002 18:45:04 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
        Jesse Barnes <jbarnes@sgi.com>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020502014504.GD32767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Anton Blanchard <anton@samba.org>,
	Andrea Arcangeli <andrea@suse.de>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
	Jesse Barnes <jbarnes@sgi.com>
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <20020502011750.M11414@dualathlon.random> <20020502002010.GA14243@krispykreme> <E172j1d-0001rS-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2002 at 03:35:20AM +0200, Daniel Phillips wrote:
> to use a hash table instead of a table lookup.  Bill Irwin suggested a btree
> would work here as well.

I remember suggesting a sorted array of extents on which binary
search could be performed. A B-tree seems unlikely but perhaps if
it were contiguously allocated and some other tricks done it might
do, maybe I don't remember the special sauce used for the occasion.


Cheers,
Bill
