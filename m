Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277246AbRKABSO>; Wed, 31 Oct 2001 20:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277262AbRKABSF>; Wed, 31 Oct 2001 20:18:05 -0500
Received: from 216-239-45-7.google.com ([216.239.45.7]:2090 "EHLO
	corp.google.com") by vger.kernel.org with ESMTP id <S277246AbRKABRz>;
	Wed, 31 Oct 2001 20:17:55 -0500
Message-ID: <3BE0A2C1.70600@google.com>
Date: Wed, 31 Oct 2001 17:17:53 -0800
From: Ben Smith <ben@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: Google's mm problem - not reproduced on 2.4.13
In-Reply-To: <E15yzlQ-00021P-00@starship.berlin> <E15z28m-0000vb-00@starship.berlin> <20011031214540.D1291@athlon.random> <E15z5Zm-000067-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> *Just in case* it's oom-related I've asked Ben to try it with one less than 
> the maximum number of memory blocks he can allocate.


I've run this test with my 3.5G machine, 3 blocks instead of 4 blocks, 
and it has the same behavior (my app gets killed, 0-order allocation 
failures, and the system stays up.
  - Ben

Ben Smith
Google, Inc


