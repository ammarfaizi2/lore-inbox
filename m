Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310423AbSCLFcR>; Tue, 12 Mar 2002 00:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310428AbSCLFcI>; Tue, 12 Mar 2002 00:32:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28945 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310423AbSCLFby>;
	Tue, 12 Mar 2002 00:31:54 -0500
Date: Tue, 12 Mar 2002 05:31:52 +0000
From: wli@holomorphy.com
To: wli@parcelfarce.linux.theplanet.co.uk, andrea@suse.de,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, riel@surriel.com, hch@infradead.org,
        phillips@bonn-fries.net
Subject: Re: 2.4.19pre2aa1
Message-ID: <20020312053152.D687@holomorphy.com>
Mail-Followup-To: wli@holomorphy.com, wli@parcelfarce.linux.theplanet.co.uk,
	andrea@suse.de, "Richard B. Johnson" <root@chaos.analogic.com>,
	linux-kernel@vger.kernel.org, riel@surriel.com, hch@infradead.org,
	phillips@bonn-fries.net
In-Reply-To: <20020312041958.C687@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020312041958.C687@holomorphy.com>; from wli@parcelfarce.linux.theplanet.co.uk on Tue, Mar 12, 2002 at 04:19:58AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 04:19:58AM +0000, wli@parcelfarce.linux.theplanet.co.uk wrote:
> 	http://www.samba.org/~anton/linux/pagecache/pagecache_before.png
> 
> 	is a histogram of the pagecache hash function's bucket distribution
> 	on an SMP ppc64 machine after some benchmark run.
> 
> 	http://www.samba.org/~anton/linux/pagecache/pagecache_after.png
> 
> 	has a histogram of a Fibonacci hashing hash function's bucket
> 	distribution on the same machine after an identical benchmark run.

akpm just pointed out to me these histograms are not quite the best
comparisons as the tables differ in size. I'll get something webabble
soon with head-to-head comparisons. OTOH the general nature of things
should be clear and the behavior of that hash function visible.


Cheers,
Bill
