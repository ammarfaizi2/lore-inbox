Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282092AbRKWJbR>; Fri, 23 Nov 2001 04:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282089AbRKWJa7>; Fri, 23 Nov 2001 04:30:59 -0500
Received: from holomorphy.com ([216.36.33.161]:34463 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S282091AbRKWJan>;
	Fri, 23 Nov 2001 04:30:43 -0500
Date: Fri, 23 Nov 2001 01:30:28 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] tree-based bootmem
Message-ID: <20011123013028.B17332@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011117011415.B1180@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20011117011415.B1180@holomorphy.com>; from wli@holomorphy.com on Sat, Nov 17, 2001 at 01:14:15AM -0800
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2001 at 01:14:15AM -0800, William Lee Irwin III wrote:
> This is a repost including some corrections of a bootmem allocator that
> tracks ranges explicitly, and uses segment trees to assist in searching
> for available memory. Perhaps it is even a new version. Some prior
> reports indicated mail headers were munged, preventing replies and some
> people from seeing it at all.

Successfully tested on mipsel without modifications to my code.

Two drivers required non-standard versions for the correct operation
of 2.4.14-oss.sgi.com on diskless serial console DecStation 5000/200.
Aside from that, nothing of the rest of the kernel, nor any of my code
was altered. Driver issues should bear no relation to bootmem.

Specifically, the 2.4.5-oss.sgi.com dz.c and a PMAD-AA-capable DEC
Lance driver (PMAD-AA driver thanks to Dave Airlie) were needed. Further
pursuit of those issues should and will be directed to arch maintainers.

Cheers,
Bill
-----------------
willir@us.ibm.com
