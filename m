Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262490AbREXXIH>; Thu, 24 May 2001 19:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262496AbREXXH5>; Thu, 24 May 2001 19:07:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1673 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262490AbREXXHr>;
	Thu, 24 May 2001 19:07:47 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15117.37952.537252.892498@pizda.ninka.net>
Date: Thu, 24 May 2001 16:07:44 -0700 (PDT)
To: Bharath Madhavan <bharath_madhavan@ivivity.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Accelerated TCP/IP support from kernel
In-Reply-To: <25369470B6F0D41194820002B328BDD20717A0@ATLOPS>
In-Reply-To: <25369470B6F0D41194820002B328BDD20717A0@ATLOPS>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bharath Madhavan writes:
 > I guess 3c905c NIC supports HW checksumming. Is this true?

Yes.

 > In this case, do we have any benchmarking for this card 
 > with and without ZERO_COPY (and HW checksumming). I am eager to
 > know by how many times did the system throughput increase?

It doesn't matter with 100baseT cards, they are slow enough that even
with the cpu doing the data copies the link may be easily saturated.
What you will get is decreased CPU utilization.

You need to go to gigabit or faster link speeds to see any real
throughput improvement.

Later,
David S. Miller
davem@redhat.com

