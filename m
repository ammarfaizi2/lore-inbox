Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267338AbRGKP4N>; Wed, 11 Jul 2001 11:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267339AbRGKP4D>; Wed, 11 Jul 2001 11:56:03 -0400
Received: from node-cffb9242.powerinter.net ([207.251.146.66]:22768 "HELO
	switchmanagement.com") by vger.kernel.org with SMTP
	id <S267338AbRGKPzw>; Wed, 11 Jul 2001 11:55:52 -0400
Message-ID: <3B4C7709.50407@switchmanagement.com>
Date: Wed, 11 Jul 2001 08:55:53 -0700
From: Brian Strand <bstrand@switchmanagement.com>
Organization: Switch Management
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2x Oracle slowdown from 2.2.16 to 2.4.4
In-Reply-To: <3B4BA19C.3050706@switchmanagement.com> <20010710195821.A5730@vger.timpanogas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jeff V. Merkey wrote:

>Oracle performance is critical in requiring fast disk access.  Oracle is
>virtually self-contained with regard to the subsystems it uses -- it 
>provides most of it's own.  Oracle slowdowns are related to either 
>problems in the networking software for remote SQL operations, and 
>disk access witb regard to jobs run locally.  If it's slower for local
>SQL processing as well as remote I would suspect a problem with the 
>low level disk interface.
>
Our Oracle jobs are almost entirely local (we got rid of all network 
access for performance reasons months ago).  Before the upgrade to 
2.4.4, they were running well enough, but now (with the only change 
being the Suse upgrade from 7.0 to 7.2) they are taking twice as long. 
 I am slightly suspicious of the kernel, as much swapping is happening 
now which was not happening before on an identical workload.  I am 
trying out 2.4.6-2 (from Hubert Mantel's builds) today to see if VM 
behavior improves.

Many Thanks,
Brian Strand
CTO Switch Management


