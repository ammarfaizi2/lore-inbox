Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317112AbSHPIrS>; Fri, 16 Aug 2002 04:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317169AbSHPIrS>; Fri, 16 Aug 2002 04:47:18 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:9863 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317112AbSHPIrR>;
	Fri, 16 Aug 2002 04:47:17 -0400
Message-ID: <3D5CBCFC.2090006@us.ibm.com>
Date: Fri, 16 Aug 2002 01:51:08 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [PATCH] add buddyinfo /proc entry
References: <3D5C6410.1020706@us.ibm.com> <20020816043140.GA2478@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
 > On Thu, Aug 15, 2002 at 07:31:44PM -0700, Dave Hansen wrote:
 >
 >> Not _another_ proc entry!
 >
 > Yes, not another one.  Why not move these to driverfs, where they
 > belong.

Could you show us how this particular situation might be laid out in a 
driverfs/kfs/gregfs tree?

It's great that you keep suggesting this, but we have another 
chicken-and-egg problem.

<SOAPBOX>
The problem with driverfs today is that it isn't worth it for _me_ to
use it to just get this one, single thing.  If I used driverfs right 
now, the only thing that I would get out of it would be ... buddyinfo! 
How is it worth my while to use it on a shared machine where most 
people probably won't be mounting driverfs, or _want_ it mounted as 
the default?
</SOAPBOX>

 > (ignore the driverfs name, it should be called kfs, or some such
 > thing, as stuff more than driver info should go there, just like
 > these entries.)

If even its most ardent supporters don't like its name...

-- 
Dave Hansen
haveblue@us.ibm.com

