Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318873AbSHRIbN>; Sun, 18 Aug 2002 04:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318875AbSHRIbN>; Sun, 18 Aug 2002 04:31:13 -0400
Received: from dsl-213-023-021-254.arcor-ip.net ([213.23.21.254]:52949 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318873AbSHRIbL>;
	Sun, 18 Aug 2002 04:31:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.31 kmap_atomic copy_*_user benefits
Date: Sun, 18 Aug 2002 10:36:48 +0200
X-Mailer: KMail [version 1.3.2]
References: <20020815232126.GR15685@holomorphy.com> <20020815233525.GW15685@holomorphy.com>
In-Reply-To: <20020815233525.GW15685@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17gLYH-0002y7-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 August 2002 01:35, William Lee Irwin III wrote:
> On Thu, Aug 15, 2002 at 04:21:26PM -0700, William Lee Irwin III wrote:
> > With and without kmap_atomic() -based copy_*_user() patches from akpm.
> > Taken on a 16x/16GB box.
> > Take 1: total throughput:
> > before:
> > Throughput 32.3019 MB/sec (NB=40.3774 MB/sec  323.019 MBit/sec)  512 procs
> > after:
> > Throughput 46.9837 MB/sec (NB=58.7296 MB/sec  469.837 MBit/sec)  512 procs
> > In the follow-ups I'll include oprofile numbers for each and vmstat logs.
> 
> doh! the workload was dbench 512

Of course you know about the butterfly effect with respect to dbench...

-- 
Daniel
