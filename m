Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266754AbRGKQoj>; Wed, 11 Jul 2001 12:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267350AbRGKQoa>; Wed, 11 Jul 2001 12:44:30 -0400
Received: from node-cffb9242.powerinter.net ([207.251.146.66]:28659 "HELO
	switchmanagement.com") by vger.kernel.org with SMTP
	id <S266754AbRGKQoT>; Wed, 11 Jul 2001 12:44:19 -0400
Message-ID: <3B4C8263.6000407@switchmanagement.com>
Date: Wed, 11 Jul 2001 09:44:19 -0700
From: Brian Strand <bstrand@switchmanagement.com>
Organization: Switch Management
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2x Oracle slowdown from 2.2.16 to 2.4.4
In-Reply-To: <3B4BA19C.3050706@switchmanagement.com> <20010711031556.A3496@athlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

>We need to restrict the problem. How are you using Oracle?  Through any
>filesystem? If yes which one? Or with rawio?  Is your workload cached
>most of the time or not?
>
Our Oracle configuration is on reiserfs on lvm on Mylex.  Our workload 
is not entirely cached, as we are working against an 8GB table, Oracle 
is configured to use slightly more than 1GB of memory, and there is 
always several MB/s of IO going on during our queries.  The "working 
set" of the main table and indexes occupies over 2GB.

Many Thanks,
Brian Strand
CTO Switch Management


