Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317701AbSHOXdI>; Thu, 15 Aug 2002 19:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317743AbSHOXdI>; Thu, 15 Aug 2002 19:33:08 -0400
Received: from holomorphy.com ([66.224.33.161]:37820 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317701AbSHOXdH>;
	Thu, 15 Aug 2002 19:33:07 -0400
Date: Thu, 15 Aug 2002 16:35:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.31 kmap_atomic copy_*_user benefits
Message-ID: <20020815233525.GW15685@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20020815232126.GR15685@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020815232126.GR15685@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2002 at 04:21:26PM -0700, William Lee Irwin III wrote:
> With and without kmap_atomic() -based copy_*_user() patches from akpm.
> Taken on a 16x/16GB box.
> Take 1: total throughput:
> before:
> Throughput 32.3019 MB/sec (NB=40.3774 MB/sec  323.019 MBit/sec)  512 procs
> after:
> Throughput 46.9837 MB/sec (NB=58.7296 MB/sec  469.837 MBit/sec)  512 procs
> In the follow-ups I'll include oprofile numbers for each and vmstat logs.

doh! the workload was dbench 512


Cheers,
Bill
