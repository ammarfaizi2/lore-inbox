Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261397AbTCOF5n>; Sat, 15 Mar 2003 00:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261401AbTCOF5n>; Sat, 15 Mar 2003 00:57:43 -0500
Received: from franka.aracnet.com ([216.99.193.44]:17329 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261397AbTCOF5m>; Sat, 15 Mar 2003 00:57:42 -0500
Date: Fri, 14 Mar 2003 22:08:24 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Alex Tomas <bzzz@tmi.comex.ru>,
       linux-kernel <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@digeo.com>, anton@samba.org
Subject: Re: [PATCH] concurrent block allocation for ext3
Message-ID: <4110000.1047708504@[10.10.2.4]>
In-Reply-To: <251250000.1047696997@flay>
References: <m3zno3grfz.fsf@lexa.home.net> <227420000.1047676948@flay> <251250000.1047696997@flay>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> before:
> Throughput 48.5304 MB/sec (NB=60.663 MB/sec  485.304 MBit/sec)  256 procs
> after:
> Throughput 58.8483 MB/sec (NB=73.5603 MB/sec  588.483 MBit/sec)  256 procs

OK, akpm wanted dbench 32 instead:

before:

Throughput 187.637 MB/sec (NB=234.546 MB/sec  1876.37 MBit/sec)  32 procs

after:

Throughput 378.664 MB/sec (NB=473.33 MB/sec  3786.64 MBit/sec)  32 procs

/me likes.

M.

