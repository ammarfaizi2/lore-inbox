Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290981AbSBLRsM>; Tue, 12 Feb 2002 12:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291038AbSBLRsA>; Tue, 12 Feb 2002 12:48:00 -0500
Received: from mons.uio.no ([129.240.130.14]:16799 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S290981AbSBLRrn>;
	Tue, 12 Feb 2002 12:47:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15465.21813.120817.244034@charged.uio.no>
Date: Tue, 12 Feb 2002 18:47:33 +0100
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Chuck Lever <cel@monkey.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove BKL from NFS read/write code + SunRPC...
In-Reply-To: <3C695401.8040503@us.ibm.com>
In-Reply-To: <15465.476.953349.720240@charged.uio.no>
	<3C695401.8040503@us.ibm.com>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dave Hansen <haveblue@us.ibm.com> writes:

     > Trond Myklebust wrote:
    >> The following patch strongly reduces BKL contention within the
    >> NFS read/write code, and within the generic RPC layer.

     > Do you have any benchmarks which showed BKL contention in the
     > NFS code?
     >   I'm not trying to criticize, I think the patch is wonderful.
     >   I want
     > to have some more numbers to say, "Look!  The BKL _is_ bad!"

See Chuck's paper on

  http://www.citi.umich.edu/projects/nfs-perf/results/cel/write-throughput.html


Cheers,
  Trond
