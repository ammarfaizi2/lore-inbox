Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311371AbSCMU5d>; Wed, 13 Mar 2002 15:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311370AbSCMU51>; Wed, 13 Mar 2002 15:57:27 -0500
Received: from [66.35.146.201] ([66.35.146.201]:64016 "EHLO int1.nea-fast.com")
	by vger.kernel.org with ESMTP id <S311368AbSCMU5M>;
	Wed, 13 Mar 2002 15:57:12 -0500
Message-Id: <200203132056.PAA04508@int1.nea-fast.com>
Content-Type: text/plain; charset=US-ASCII
From: walter <walt@nea-fast.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: oracle rmap kernel version
Date: Wed, 13 Mar 2002 15:56:52 -0500
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <794826DE8867D411BAB8009027AE9EB913D03D23@FMSMSX38> <3C8FAB25.1080706@us.ibm.com>
In-Reply-To: <3C8FAB25.1080706@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, <davis@jdhouse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 March 2002 02:40 pm, you wrote:
> Chen, Kenneth W wrote:
> > Depends on your hardware configuration and how you stress your system
> > with db workload, you should consider some performance patch from the
> > linux scalability effort project.
> > http://lse.sourceforge.net
>
> In particular, take a look at the rollup patches:
> http://sourceforge.net/project/shownotes.php?release_id=77093
>
> This one has been tested pretty well.
> http://prdownloads.sourceforge.net/lse/lse01.patch
>
> This could use some more testing, but is not bad by any means:
> http://prdownloads.sourceforge.net/lse/lse02.patch
>
> BTW, what SCSI controllers are you planning on using?  Some are better
> than others.

Not sure right off the top of my head. I'm planning on using 2 controllers, 
each from a different manufactures. My reasoning behind this is two fold. 
Number one is in case a "bug" creeps up with one of the drivers I can still 
string all the drives off the other controller. Performance will decrease, 
but I'd rather be slow than dead in the water. The second reason is the 
probability of both controllers failing (hardware) at same time due to a bad 
chip batch at the manufacture.  Do you have any suggestions on controllers? 
Adaptec and IBM (not sure which models) ?

Thanks for your input!
walt 
