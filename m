Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311377AbSCMVMQ>; Wed, 13 Mar 2002 16:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311375AbSCMVMF>; Wed, 13 Mar 2002 16:12:05 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:25337 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S311377AbSCMVLz>;
	Wed, 13 Mar 2002 16:11:55 -0500
Message-ID: <3C8FC065.4060904@us.ibm.com>
Date: Wed, 13 Mar 2002 13:11:01 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: walter <walt@nea-fast.com>
CC: linux-kernel@vger.kernel.org, davis@jdhouse.org,
        Gerrit Huizenga <gerrit@us.ibm.com>
Subject: Re: oracle rmap kernel version
In-Reply-To: <794826DE8867D411BAB8009027AE9EB913D03D23@FMSMSX38> <3C8FAB25.1080706@us.ibm.com> <200203132056.PAA04508@int1.nea-fast.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

walter wrote:
> Not sure right off the top of my head. I'm planning on using 2 controllers, 
> each from a different manufactures. My reasoning behind this is two fold. 
> Number one is in case a "bug" creeps up with one of the drivers I can still 
> string all the drives off the other controller. Performance will decrease, 
> but I'd rather be slow than dead in the water. The second reason is the 
> probability of both controllers failing (hardware) at same time due to a bad 
> chip batch at the manufacture.  Do you have any suggestions on controllers? 
> Adaptec and IBM (not sure which models) ?

I haven't done any of the testing myself.  But, I was told that the 
Adaptec AIC stuff is good.  I think that the LSE patch has been tested 
on with Adaptec (aic7xxx) and QLogic fiber channel controllers.  I guess 
that the QLogic stuff is liked because the drivers are open source.

I was surprised to see that the ServeRAID driver isn't touched by the 
lse patch.  I thought that it still uses the io_request_lock in 2.4.

Care to add anything, Gerrit?

-- 
Dave Hansen
haveblue@us.ibm.com

