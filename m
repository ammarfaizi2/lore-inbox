Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288834AbSAXSSZ>; Thu, 24 Jan 2002 13:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288810AbSAXSSO>; Thu, 24 Jan 2002 13:18:14 -0500
Received: from dsl-213-023-043-085.arcor-ip.net ([213.23.43.85]:23715 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288801AbSAXSSF>;
	Thu, 24 Jan 2002 13:18:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: rwhron@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18pre4aa1
Date: Thu, 24 Jan 2002 07:27:43 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020124002342.A630@earthlink.net>
In-Reply-To: <20020124002342.A630@earthlink.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16ToWW-0002mf-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 24, 2002 06:23 am, rwhron@earthlink.net wrote:
> Benchmarks on 2.4.18pre4aa1 and lots of other kernels at:
> http://home.earthlink.net/~rwhron/kernel/k6-2-475.html

  "dbench 64, 128, 192 on ext2fs. dbench may not be the best I/O benchmark, 
  but it does create a high load, and may put some pressure on the cpu and 
  i/o schedulers. Each dbench process creates about 21 megabytes worth of 
  files, so disk usage is 1.3 GB, 2.6 GB and 4.0 GB for the dbench runs. Big 
  enough so the tests cannot run from the buffer/page caches on this box."

Thanks kindly for the testing, but please don't use dbench any more for 
benchmarks.  If you are testing stability, fine, but dbench throughput 
numbers are not good for much more than wild goose chases.

Even when mostly uncached, dbench still produces flaky results.

-- 
Daniel

