Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbUCCIDo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 03:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbUCCIDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 03:03:44 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:33727 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262416AbUCCIDj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 03:03:39 -0500
Message-ID: <40459159.1090501@namesys.com>
Date: Wed, 03 Mar 2004 11:03:37 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Andi Kleen <ak@suse.de>, David Weinehall <david@southpole.se>,
       Dax Kelson <dax@gurulabs.com>, Peter Nelson <pnelson@andrew.cmu.edu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, ext3-users@redhat.com,
       jfs-discussion@www-124.southbury.usf.ibm.com, reiserfs-list@namesys.com,
       linux-xfs@oss.sgi.com
Subject: Re: Desktop Filesystem Benchmarks in 2.6.3
References: <4044119D.6050502@andrew.cmu.edu> <4044366B.3000405@namesys.com> <4044B787.7080301@andrew.cmu.edu> <1078266793.8582.24.camel@mentor.gurulabs.com> <20040302224758.GK19111@khan.acc.umu.se> <40453538.8050103@animezone.org> <20040303014115.GP19111@khan.acc.umu.se> <20040303014115.GP19111@khan.acc.umu.se.suse.lists.linux.kernel> <p73ptbu4psx.fsf@brahms.suse.de> <20040303074756.A25861@infradead.org>
In-Reply-To: <20040303074756.A25861@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Wed, Mar 03, 2004 at 03:39:26AM +0100, Andi Kleen wrote:
>  
>
>>A lot of this is actually optional features the other FS don't have,
>>like support for separate realtime volumes and compat code for old 
>>revisions, journaled quotas etc. I think you could
>>relatively easily do a "mini xfs" that would be a lot smaller. 
>>    
>>
>
>And a whole lot of code to stay somewhat in sync with other codebases..
>
>
>
>  
>
What is significant is not the affect of code size on modern 
architectures, code size hurts developers as the code becomes very hard 
to make deep changes to.  It is very important to carefully design your 
code to be easy to change.  This is why we tossed the V3 code and wrote 
V4 from scratch using plugins at every conceivable abstraction layer.  I 
think V4 will be our last rewrite from scratch because of our plugins, 
and because of how easy we find the code to work on now.

I think XFS is going to stagnate over time based on the former 
developers who have told me how hard it is to work on the code.  
Christoph probably disagrees, and he knows the XFS code far better than 
I.;-)

-- 
Hans


