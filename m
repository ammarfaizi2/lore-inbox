Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314674AbSEBRYG>; Thu, 2 May 2002 13:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314676AbSEBRYG>; Thu, 2 May 2002 13:24:06 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:16378 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314674AbSEBRYE>;
	Thu, 2 May 2002 13:24:04 -0400
Message-ID: <3CD167A7.3EFEC1B5@vnet.ibm.com>
Date: Thu, 02 May 2002 11:21:59 -0500
From: Dave Engebretsen <engebret@vnet.ibm.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <E171aOa-0001Q6-00@starship> <20020429153500.B28887@dualathlon.random> <E172K9n-0001Yv-00@starship> <20020501042341.G11414@dualathlon.random> <20020501180547.GA1212440@sgi.com> <20020502011750.M11414@dualathlon.random> <20020502002010.GA14243@krispykreme> <20020502030113.Q11414@dualathlon.random> <20020502152825.GE10495@krispykreme> <20020502163135.GI32767@holomorphy.com>
X-MIMETrack: Itemize by SMTP Server on d27ml101/27/M/IBM(Release 5.0.10 |March 22, 2002) at
 05/02/2002 12:23:24 PM,
	Serialize by Router on d27ml101/27/M/IBM(Release 5.0.10 |March 22, 2002) at
 05/02/2002 12:23:26 PM,
	Serialize complete at 05/02/2002 12:23:26 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> On Fri, May 03, 2002 at 01:28:25AM +1000, Anton Blanchard wrote:
> > Also when we do hotplug memory support will discontigmem be able to
> > efficiently handle memory turning up all over the place in the memory
> > map?
> 
> Would the flip side of that coin perhaps be implementing a way to be a
> good logically partitioned citizen and cooperatively offline memory?
> 
> Cheers,
> Bill

Yes, both add and remove are needed to be a good citizen.  One could
spend all kinds of time coming up with good huristicts to do that
automatically :)

At a mimimum, manual off line of memory would be nice.

Dave.
