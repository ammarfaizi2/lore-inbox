Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRAIQui>; Tue, 9 Jan 2001 11:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131224AbRAIQu2>; Tue, 9 Jan 2001 11:50:28 -0500
Received: from monza.monza.org ([209.102.105.34]:1294 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S129226AbRAIQuO>;
	Tue, 9 Jan 2001 11:50:14 -0500
Date: Tue, 9 Jan 2001 08:50:01 -0800
From: Tim Wright <timw@splhi.com>
To: Andi Kleen <ak@suse.de>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
        Venkatesh Ramamurthy <Venkateshr@ami.com>,
        "'Pavel Machek'" <pavel@suse.cz>, adefacc@tin.it,
        linux-kernel@vger.kernel.org, timw@splhi.com
Subject: Re: Confirmation request about new 2.4.x. kernel limits
Message-ID: <20010109085001.B2971@scutter.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Andi Kleen <ak@suse.de>,
	Matti Aarnio <matti.aarnio@zmailer.org>,
	Venkatesh Ramamurthy <Venkateshr@ami.com>,
	'Pavel Machek' <pavel@suse.cz>, adefacc@tin.it,
	linux-kernel@vger.kernel.org, timw@splhi.com
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95137@ATL_MS1> <20010109142156.L25659@mea-ext.zmailer.org> <20010109082749.A2971@scutter.internal.splhi.com> <20010109174446.A5602@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010109174446.A5602@gruyere.muc.suse.de>; from ak@suse.de on Tue, Jan 09, 2001 at 05:44:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 05:44:46PM +0100, Andi Kleen wrote:
> On Tue, Jan 09, 2001 at 08:27:49AM -0800, Tim Wright wrote:
> > you are correct in saying that ia32 systems don't have IOMMU hardware, but
> > it's unfortunate that we don't support 64-bit PCI bus master cards, since
> > they're inexpensive and fairly common now. For instance, the Qlogic ISP SCSI
> > cards can do 64-bit addressing, as can many others. Has anybody taken a look
> > at enabling this ?
> 
> Problem is that it needs a driver interface change and cooperation from the
> drivers. 
> 
> -Andi

I thought as much. Sounds like 2.5 material really, although it might be
interesting to see if I can make a patch to play with.

Regards,

Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
