Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262516AbVDLRfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262516AbVDLRfL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 13:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbVDLReA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 13:34:00 -0400
Received: from mail.kroah.org ([69.55.234.183]:1697 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262504AbVDLRbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 13:31:14 -0400
Date: Tue, 12 Apr 2005 10:30:33 -0700
From: Greg KH <greg@kroah.com>
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Ihalainen Nickolay <ihanic@dev.ehouse.ru>, admin@list.net.ru,
       linux-kernel@vger.kernel.org, Wen Xiong <wendyx@us.ibm.com>
Subject: Re: Digi Neo 8: linux-2.6.12_r2  jsm driver
Message-ID: <20050412173033.GC14857@kroah.com>
References: <335DD0B75189FB428E5C32680089FB9F12215B@mtk-sms-mail01.digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <335DD0B75189FB428E5C32680089FB9F12215B@mtk-sms-mail01.digi.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 11:54:04AM -0500, Kilau, Scott wrote:
> Hi Greg,
> 
> > What features?  Didn't we end up with a valid resolution to all of the
> > additional stuff in the jsm driver that you originally asked for?  Why
> > not work on adding those new features to the serial core, and then
> there
> > would be no issue with accepting your other driver?
> 
> I appreciate your "calm" response. =)
> 
> DPA (Digi Port Authority) support (the special ioctls)
> and /proc (and /sys) files were left unresolved.
> Wendy had no choice but to remove them to get the driver
> into the kernel sources.

I understand.

> IBM was okay with removing them, so I was okay with doing it as well,
> as the whole point of the JSM driver is to support IBM's card directly.
> 
> However, removing those things are just unacceptable for Digi for our
> cards.

Ok, but wasn't it possible to get those additional things added to the
main kernel serial core, which would then provide everything that Digi's
customers are accustomed to?  And then this thread would not be an issue
at all.

And yes, I understand you need to support 2.4, but that's not a
kernel.org issue, and you can continue to have your 2.4 driver.

thanks,

greg k-h
