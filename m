Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315334AbSGEAI7>; Thu, 4 Jul 2002 20:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317456AbSGEAHL>; Thu, 4 Jul 2002 20:07:11 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:35742 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317440AbSGEAFx>; Thu, 4 Jul 2002 20:05:53 -0400
Message-ID: <3D24E368.5060905@us.ibm.com>
Date: Thu, 04 Jul 2002 17:08:08 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from driverfs
References: <Pine.GSO.4.21.0207041953370.12731-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Thu, 4 Jul 2002, Dave Hansen wrote:
> 
>>CC'ing Al for comments...
>>
>>Greg KH wrote:
>>
>>>bleah, a proliferation of a zillion little spinlocks all across the
>>>kernel is not my idea of fun :(
>>
>>A zillion locks each with a single purpose is a lot more fun than 1 
>>lock with a zillion different uses.
> 
> Wrong.  It's fun if you are into taking a turd and turning it into a thin film
> spread over all available surfaces.  The former has a chance to be removed.
> The latter is hopeless.
> 
> "Zillion little spinlocks" means that kernel is scaled into oblivion.
> Literally.  If you want to play with resulting body - feel free, but
> I like it less kinky.
> 

So, can we remove the spread in this case?

-- 
Dave Hansen
haveblue@us.ibm.com

