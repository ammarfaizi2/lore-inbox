Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263004AbVDLViY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263004AbVDLViY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 17:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbVDLVey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 17:34:54 -0400
Received: from waste.org ([216.27.176.166]:35047 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263004AbVDLVdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 17:33:19 -0400
Date: Tue, 12 Apr 2005 14:32:54 -0700
From: Matt Mackall <mpm@selenic.com>
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       Ihalainen Nickolay <ihanic@dev.ehouse.ru>, admin@list.net.ru,
       linux-kernel@vger.kernel.org, Wen Xiong <wendyx@us.ibm.com>
Subject: Re: Digi Neo 8: linux-2.6.12_r2  jsm driver
Message-ID: <20050412213253.GO25554@waste.org>
References: <335DD0B75189FB428E5C32680089FB9F122163@mtk-sms-mail01.digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <335DD0B75189FB428E5C32680089FB9F122163@mtk-sms-mail01.digi.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 03:21:15PM -0500, Kilau, Scott wrote:
> Hi Greg, all,
> 
> > Ok, but wasn't it possible to get those additional things added to the
> > main kernel serial core, which would then provide everything that
> Digi's
> > customers are accustomed to?
> 
> Yes, it is my intention in the future to add support for the needed
> information,
> probably at the /sys level.
> The key is to be able to get at the tty information without
> having to open up the tty/port.
> 
> Again, I understand why you required the changes in JSM,
> IBM didn't need DPA support, so I had no problem with removing the
> support.
> 
> However, neither IBM nor Digi wants this thread's patch to be applied,
> and yet Christoph wants to do it, completely out of spite, to break our
> out-of-tree open source driver.

The problem is that your "out-of-tree open source driver" is an
inadequate solution. Out of tree drivers are a pain for users,
developers, and distributors. As such, we make very little allowance
for their concerns, especially when they stand in the way of improving
things that _are_ in the kernel.

The proposed patch makes the in-tree driver work for hardware that it
didn't before which is a net good for our users. The ball is now in
your court: replace it with an acceptable version of your driver in a
timely fashion. Saying you'll get around to it some day when you're
done supporting 2.4 is not timely. Nor does it serve your users.

Alternately, provide a good reason not to include said patch without
reference to might-as-well-not-exist-as-far-as-we're-concerned out of
tree drivers or the similarly irrelevant wishes of nebulous corporate
entities.

-- 
Mathematics is the supreme nostalgia of our time.
