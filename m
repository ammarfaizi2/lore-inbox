Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130069AbRBVBZe>; Wed, 21 Feb 2001 20:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129170AbRBVBZZ>; Wed, 21 Feb 2001 20:25:25 -0500
Received: from [209.102.105.34] ([209.102.105.34]:1550 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S130284AbRBVBYk>;
	Wed, 21 Feb 2001 20:24:40 -0500
Date: Wed, 21 Feb 2001 17:24:00 -0800
From: Tim Wright <timw@splhi.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Scott Long <smlong@teleport.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux OS boilerplate
Message-ID: <20010221172400.C2118@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Scott Long <smlong@teleport.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E14UfQ8-00027g-00@the-village.bc.nu> <m1lmr30yvu.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m1lmr30yvu.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Mon, Feb 19, 2001 at 03:07:33AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2001 at 03:07:33AM -0700, Eric W. Biederman wrote:
> With linux-2.4 able to do a complete PCI bus setup it isn't as bad it used
> to be, but it's still pretty significant.
 
For an incomplete subset of chipsets. Serverworks doesn't work correctly for
a start (see the threads relating to having to kill the Serverworks fixup code
and rely on the BIOS to see all the PCI busses on larger systems). Of course,
this is due to Serverworks refusal to release documentation (yes, I've heard
the excuses regarding protection of IP), and it's a worrisome. What else are
we potentially failing to setup on this chipset ?

Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
