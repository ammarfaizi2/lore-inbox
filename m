Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315618AbSECJ2B>; Fri, 3 May 2002 05:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315619AbSECJ2A>; Fri, 3 May 2002 05:28:00 -0400
Received: from holomorphy.com ([66.224.33.161]:32986 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315618AbSECJ17>;
	Fri, 3 May 2002 05:27:59 -0400
Date: Fri, 3 May 2002 02:26:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020503092643.GR32767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020503080433.R11414@dualathlon.random> <4023859403.1020382422@[10.10.2.3]> <20020503103813.K11414@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2002 at 10:38:13AM +0200, Andrea Arcangeli wrote:
> You can use 64G "sucessfully" just now too with 2.4.19pre8 too, as said
> in the earlier email there are many applications that doesn't care if
> there's only a few meg of zone_normal and for them 2.4.19pre8 is just
> fine (actually -aa is much better for the bounce buffers and other vm
> fixes in that area). If all the load is in userspace current 2.4 is just

Have you done testing with 64GB? What sort of failure modes are you
seeing with it? I've been hearing about more severe failure modes in
practice on 32GB, Martin, could you comment on this?


Cheers,
Bill
