Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310972AbSCMSqe>; Wed, 13 Mar 2002 13:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310979AbSCMSqY>; Wed, 13 Mar 2002 13:46:24 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:30483 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S310972AbSCMSqN>; Wed, 13 Mar 2002 13:46:13 -0500
Message-ID: <3C8F9E73.6000200@namesys.com>
Date: Wed, 13 Mar 2002 21:46:11 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020310
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Martin Dalecki <dalecki@evision-ventures.com>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com
Subject: Re: PROBLEM: Kernel Panic on 2.5.6 and 2.5.7-pre1 boot [PATCH] and
 discussion of Linux testing procedures
In-Reply-To: <Pine.GSO.4.21.0203130903470.22930-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:

>
>
>Proposal is a bit naive, though - in most of the cases fuckups merrily
>pass original testing.
>
>
>
No, I think we catch 70-85%.  Namesys internal bad patches frequently 
pass original testing of patch author and are caught by professional 
tester whose specialty is testing reiserfs patches.  You just haven't 
seen these bad patches, so you don't realize how effective the catching 
is.;-)  There have been a lot of catches.;-)  It is not simply a matter 
of skill in testing though: you need a second person to test it in the 
way that the author did not think to test it (e.g. by booting to the 
right kernel, everyone on this list has made that benchmarking/testing 
error a few times, yes....;-) ).

Hans


