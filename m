Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbUCCOQW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 09:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbUCCOQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 09:16:22 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:3213 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S262456AbUCCOQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 09:16:17 -0500
Message-ID: <4045E8B0.4090001@namesys.com>
Date: Wed, 03 Mar 2004 17:16:16 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
CC: Mike Gigante <mg@sgi.com>,
       Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
       David Weinehall <david@southpole.se>,
       Andrew Ho <andrewho@animezone.org>, Dax Kelson <dax@gurulabs.com>,
       Peter Nelson <pnelson@andrew.cmu.edu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, ext3-users@redhat.com,
       jfs-discussion@www-124.southbury.usf.ibm.com, reiserfs-list@namesys.com,
       linux-xfs@oss.sgi.com
Subject: Re: Desktop Filesystem Benchmarks in 2.6.3
References: <KHEHKKKAAILFJGJCHDCAAEFFEKAA.mg@sgi.com> <1078319654.1113.10.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1078319654.1113.10.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana wrote:

>
>
>As I said, it could have been a kernel bug, or maybe I simply didn't
>understand the implications of recovery, but xfs_repair was totally
>unable to fix the problem. It instructed me to use "dd" to move the
>volume to a healthy disk and retry the operation, but it was not easy to
>do that as I explained before.
>
>
>
>  
>
I think that your expectation is unreasonable.  XFS was designed for 
machines where popping in a working hard drive was feasible.  Making a 
disk layout adaptable to any arbitrary block going bad is more work than 
you might think, and for their intended market (not laptops) they did 
the right thing. 

You can buy cables that allow you to connect laptop drives to desktops. 

-- 
Hans


