Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129292AbRCWBoO>; Thu, 22 Mar 2001 20:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129321AbRCWBn5>; Thu, 22 Mar 2001 20:43:57 -0500
Received: from monza.monza.org ([209.102.105.34]:1290 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S129292AbRCWBnn>;
	Thu, 22 Mar 2001 20:43:43 -0500
Date: Thu, 22 Mar 2001 17:42:33 -0800
From: Tim Wright <timw@splhi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Woller, Thomas" <twoller@crystal.cirrus.com>, andrew.grover@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: Incorrect mdelay() results on Power Managed Machines x86
Message-ID: <20010322174233.A1651@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Woller, Thomas" <twoller@crystal.cirrus.com>,
	andrew.grover@intel.com, linux-kernel@vger.kernel.org
In-Reply-To: <973C11FE0E3ED41183B200508BC7774C0124F077@csexchange.crystal.cirrus.com> <E14gEeH-0003Z4-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14gEeH-0003Z4-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Mar 22, 2001 at 11:37:43PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If it's a 500MHz Thinkpad, then I'm guessing it's something like a 600X.
That doesn't have Speedstep. The speed changes are done by some circuitry
in the laptop. I can try to find out more if this would help.
The newer machines are using Speedstep.

Tim

On Thu, Mar 22, 2001 at 11:37:43PM +0000, Alan Cox wrote:
> > 	thanks, i just tested the "notsc" option (.config has CONFIG_X86_TSC
> > enabled=y, but CONFIG_M586TSC is not enabled.. if that's ok), but this time
> ...
> > boot and stay on battery power exclusively.  did anyone else expect this
> > behaviour?  
> 
> Errmm no.. 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
