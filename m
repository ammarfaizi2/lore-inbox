Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAIQpS>; Tue, 9 Jan 2001 11:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129532AbRAIQpJ>; Tue, 9 Jan 2001 11:45:09 -0500
Received: from Cantor.suse.de ([194.112.123.193]:18963 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129383AbRAIQo7>;
	Tue, 9 Jan 2001 11:44:59 -0500
Date: Tue, 9 Jan 2001 17:44:46 +0100
From: Andi Kleen <ak@suse.de>
To: Matti Aarnio <matti.aarnio@zmailer.org>,
        Venkatesh Ramamurthy <Venkateshr@ami.com>,
        "'Pavel Machek'" <pavel@suse.cz>, adefacc@tin.it,
        linux-kernel@vger.kernel.org
Cc: timw@splhi.com
Subject: Re: Confirmation request about new 2.4.x. kernel limits
Message-ID: <20010109174446.A5602@gruyere.muc.suse.de>
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95137@ATL_MS1> <20010109142156.L25659@mea-ext.zmailer.org> <20010109082749.A2971@scutter.internal.splhi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010109082749.A2971@scutter.internal.splhi.com>; from timw@splhi.com on Tue, Jan 09, 2001 at 08:27:49AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 08:27:49AM -0800, Tim Wright wrote:
> you are correct in saying that ia32 systems don't have IOMMU hardware, but
> it's unfortunate that we don't support 64-bit PCI bus master cards, since
> they're inexpensive and fairly common now. For instance, the Qlogic ISP SCSI
> cards can do 64-bit addressing, as can many others. Has anybody taken a look
> at enabling this ?

Problem is that it needs a driver interface change and cooperation from the
drivers. 

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
