Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317603AbSHOXTK>; Thu, 15 Aug 2002 19:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317606AbSHOXTK>; Thu, 15 Aug 2002 19:19:10 -0400
Received: from holomorphy.com ([66.224.33.161]:31932 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317603AbSHOXTJ>;
	Thu, 15 Aug 2002 19:19:09 -0400
Date: Thu, 15 Aug 2002 16:21:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.31 kmap_atomic copy_*_user benefits
Message-ID: <20020815232126.GR15685@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With and without kmap_atomic() -based copy_*_user() patches from akpm.
Taken on a 16x/16GB box.

Take 1: total throughput:


before:
Throughput 32.3019 MB/sec (NB=40.3774 MB/sec  323.019 MBit/sec)  512 procs

after:
Throughput 46.9837 MB/sec (NB=58.7296 MB/sec  469.837 MBit/sec)  512 procs

In the follow-ups I'll include oprofile numbers for each and vmstat logs.


Cheers,
Bill
