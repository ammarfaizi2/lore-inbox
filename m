Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318518AbSHPQP6>; Fri, 16 Aug 2002 12:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318519AbSHPQP6>; Fri, 16 Aug 2002 12:15:58 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:53961 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318518AbSHPQP6>;
	Fri, 16 Aug 2002 12:15:58 -0400
Message-ID: <3D5D25FE.8010002@us.ibm.com>
Date: Fri, 16 Aug 2002 09:19:10 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [PATCH] add buddyinfo /proc entry
References: <3D5C6410.1020706@us.ibm.com> <20020816043140.GA2478@kroah.com> <3D5CBCFC.2090006@us.ibm.com> <20020816143925.GA3957@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> All it takes is one line added to /etc/fstab mounting driverfs at /sys.
> As the code is not a .config option, you are using it if you mount it or
> not :)  The fact that no one else will look at that mount point,
> shouldn't matter to you.
> 
> And yes, for just one thing (hey, why don't you move _all_ the vm stats
> over to it), it is worth adding that one line.  And you'll eventually
> have to do it anyway, as these things _will_ be moving there.
> 
> Hell, tell me which machine you are using, and I'll go add it.

How long has it been in the tree (2.4 and 2.5)?  I'll add it to my 
machine, but I am anticipating a 3 hour conversation as I explain to 
the other users why they got dropped to a root prompt because driverfs 
isn't supported when they boot.

-- 
Dave Hansen
haveblue@us.ibm.com

