Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269524AbUINROe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269524AbUINROe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 13:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269536AbUINRNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 13:13:23 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:10974 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S269524AbUINRH3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 13:07:29 -0400
Date: Tue, 14 Sep 2004 19:07:28 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Hanna Linder <hannal@us.ibm.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, rth@twiddle.net,
       ink@jurassic.park.msu.ru, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFT 2.6.9-rc1 alpha sys_alcor.c] [1/2] convert pci_find_device to pci_get_device
Message-ID: <20040914170728.GB3580@MAIL.13thfloor.at>
Mail-Followup-To: Hanna Linder <hannal@us.ibm.com>,
	William Lee Irwin III <wli@holomorphy.com>, rth@twiddle.net,
	ink@jurassic.park.msu.ru, linux-kernel@vger.kernel.org,
	greg@kroah.com
References: <806400000.1095118633@w-hlinder.beaverton.ibm.com> <20040914020257.GF9106@holomorphy.com> <20040914031705.GX9106@holomorphy.com> <925340000.1095177130@w-hlinder.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <925340000.1095177130@w-hlinder.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 08:52:10AM -0700, Hanna Linder wrote:
> --On Monday, September 13, 2004 08:17:05 PM -0700 William Lee Irwin III <wli@holomorphy.com> wrote:
> 
> > On Mon, Sep 13, 2004 at 07:02:57PM -0700, William Lee Irwin III wrote:
> >> I can run it through a compiler, but I won't be able to do meaningful
> >> runtime testing on it as I only have tincup and alphapc systems. They
> >> look safe at first glance.
> > 
> > More specifically, if these were merely alpha-specific drivers, I could
> > do meaningful testing as they would attempt to be detected this way.
> > But this is system-specific initialization executed conditionally on
> > the system type, so as the systems I have are not the ones affected by
> > these patches, if I were to attempt a runtime test I would merely
> > discover that the code was not executed.
> 
> Bill,
> 
> That is fine if you could just compile it that would satisfy me.

Hi Hanna!

if you need a 'quick' cross compiling solution
next time, you can use the cross compiling at

 http://vserver.13thfloor.at/Stuff/Cross/
 http://vserver.13thfloor.at/Stuff/Cross/howto.info

if I get around, I'll update it to recent 3.4
compilers but 3.3.3 and 3.3.4 works fine ...

HTH,
Herbert

> Thanks.
> 
> Hanna
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
