Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbUCCJfT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 04:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbUCCJfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 04:35:19 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:16845 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262217AbUCCJfO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 04:35:14 -0500
Message-ID: <4045A6D0.6050203@namesys.com>
Date: Wed, 03 Mar 2004 12:35:12 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Weinehall <david@southpole.se>, Dax Kelson <dax@gurulabs.com>,
       Peter Nelson <pnelson@andrew.cmu.edu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, ext3-users@redhat.com,
       jfs-discussion@www-124.southbury.usf.ibm.com, reiserfs-list@namesys.com,
       linux-xfs@oss.sgi.com
Subject: Re: Desktop Filesystem Benchmarks in 2.6.3
References: <4044119D.6050502@andrew.cmu.edu> <4044366B.3000405@namesys.com>	 <4044B787.7080301@andrew.cmu.edu>	 <1078266793.8582.24.camel@mentor.gurulabs.com>	 <20040302224758.GK19111@khan.acc.umu.se> <40453538.8050103@animezone.org>	 <20040303014115.GP19111@khan.acc.umu.se>	 <20040303014115.GP19111@khan.acc.umu.se.suse.lists.linux.kernel>	 <p73ptbu4psx.fsf@brahms.suse.de> <20040303074756.A25861@infradead.org>	 <40459159.1090501@namesys.com> <1078301777.4446.5.camel@laptop.fenrus.com>
In-Reply-To: <1078301777.4446.5.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Wed, 2004-03-03 at 09:03, Hans Reiser wrote:
>  
>
>>  I 
>>think V4 will be our last rewrite from scratch because of our plugins, 
>>and because of how easy we find the code to work on now.
>>    
>>
>
>can we quote you on that 3 years from now ? ;-)
>  
>
Yes, I think so.

We are going to add a nice little optimization for compiles to Reiser4 
as a result of thinking about compile benchmarks.  We are going to sort 
filenames (and their corresponding file bodies) whose penultimate 
character is . by their last character first.  It seems this is optimal, 
and it is simple, and it is without any real world drawbacks.  This is 
easy for us because of our plugin design.

-- 
Hans


