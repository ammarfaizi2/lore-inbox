Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVDCGgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVDCGgi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 01:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVDCGgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 01:36:38 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:43166 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S261532AbVDCGgc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 01:36:32 -0500
From: David Lang <david.lang@digitalinsight.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Paul Jackson'" <pj@engr.sgi.com>, mingo@elte.hu, nickpiggin@yahoo.com.au,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Date: Sat, 2 Apr 2005 22:36:09 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: RE: Industry db benchmark result on recent 2.6 kernels
In-Reply-To: <200504020205.j32256g05369@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.62.0504022228080.5402@qynat.qvtvafvgr.pbz>
References: <200504020205.j32256g05369@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Apr 2005, Chen, Kenneth W wrote:

> To run this "industry db benchmark", assuming you have a 32-way numa box,
> I recommend buying the following:
>
> 512 GB memory
> 1500 73 GB 15k-rpm fiber channel disks
> 50 hardware raid controllers, make sure you get the top of the line model
>   (the one has 1GB memory in the controller).
> 25 fiber channel controllers
> 4  gigabit ethernet controllers.
> 12 rack frames

Ken, given that you don't have the bandwidth to keep all of those disks 
fully utilized, do you have any idea how big a performance hit you would 
take going to larger, but slower SATA drives?

given that this would let you get the same storage with about 1200 fewer 
drives (with corresponding savings in raid controllers, fiberchannel 
controllers and rack frames) it would be interesting to know how close it 
would be (for a lot of people the savings, which probably are within 
spitting distance of $1M could be work the decrease in performance)

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
