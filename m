Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbULPK7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbULPK7z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 05:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbULPK7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 05:59:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61312 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261927AbULPK7x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 05:59:53 -0500
Date: Thu, 16 Dec 2004 06:14:52 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Horms <horms@verge.net.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergey Vlasov <vsu@altlinux.ru>,
       Jason Baron <jbaron@redhat.com>
Subject: Re: tty/ldisc fix in 2.4
Message-ID: <20041216081452.GA8113@logos.cnet>
References: <20041216044227.GC13680@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041216044227.GC13680@verge.net.au>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 01:42:29PM +0900, Horms wrote:
> Hi,

Hi Horms,

> I am unable to find a fix for the tty/ldisc problem (CAN-2004-0814)
> in 2.4.28 or 2.4 bitkeeper. I am wondering if anyone can either
> point me to what I am missing or indicate if there is a reason
> the patch hasn't been included. e.g. it slipped through the cracks.

The patch has not been included in 2.4.28 because it was too late in the 
v2.4.28 cycle for them to be included - they are quite intrusive.

And they there didnt seem stable at the time - but yes - we
should now make an effort to include the locking fixes in 2.4.29. 

> The last I can find of it is here:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0410.3/1750.html

Jason, can you point us at your last patch ? 
Has it been deployed in production ?

> I am just curious, I am quite happy applying Jason Baron's patch.

Sergey, I recall you seeing SieFS breakage due to Jason's patch - 
what was your finding on that?

