Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314610AbSEBQHo>; Thu, 2 May 2002 12:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314611AbSEBQHn>; Thu, 2 May 2002 12:07:43 -0400
Received: from holomorphy.com ([66.224.33.161]:49878 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314610AbSEBQHl>;
	Thu, 2 May 2002 12:07:41 -0400
Date: Thu, 2 May 2002 09:06:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020502160618.GH32767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <E172K9n-0001Yv-00@starship> <20020501042341.G11414@dualathlon.random> <E172gnj-0001pS-00@starship> <20020502024740.P11414@dualathlon.random> <20020502023711.GF32767@holomorphy.com> <20020502175946.H11414@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2002 at 07:37:11PM -0700, William Lee Irwin III wrote:
>> Which ones did you have in mind? I did poke around this area a bit, and

On Thu, May 02, 2002 at 05:59:46PM +0200, Andrea Arcangeli wrote:
> all of them, if you implement a mechanism to skip one of the pgdat
> loops, you could skip them of all then.

Not quite; I only had in mind a per-cpu free pages counter for nr_free_pages.


Cheers,
Bill
