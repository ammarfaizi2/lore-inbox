Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbVEWIcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVEWIcG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 04:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVEWIcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 04:32:06 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:29570 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261857AbVEWIbz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 04:31:55 -0400
Date: Mon, 23 May 2005 14:00:24 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Phil Oester <kernel@linuxace.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc4 random oopses
Message-ID: <20050523083024.GB3611@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20050519153324.GA17914@linuxace.com> <E1DZOFT-0001JJ-00@gondolin.me.apana.org.au> <20050521145711.GA28132@linuxace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050521145711.GA28132@linuxace.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2005 at 03:02:08PM +0000, Phil Oester wrote:
> On Sat, May 21, 2005 at 05:18:15PM +1000, Herbert Xu wrote:
> > How long can your machine stay up under 2.6.11/2.6.12-rc4? Is 2.6.10
> > still stable if rebuild it?
> 
> Machine stays up 'forever' on 2.6.10, dies within ~4 hours on 2.6.11+.
> Yes, I have rebuilt 2.6.10 with some backported patches, and it still
> works fine.
> 
> > If 2.6.10 is still proving to be stable, then please do a bisection
> > search on the releases between 2.6.10/2.6.11.  That may be the only
> > way we can track this problem down.
> 
> Unfortunately the box is the firewall for my employer's west coast office
> so I can only get away with one unexplained natural phenomenon per
> day.  May take awhile...
> 
> Phil 

Hello,

Is it possilbe to try recreating the problems with 2.6.12-rc4-mm2 with kdump 
enabled? Please refer Documentation/kdump.txt in 2.6.12-rc4-mm2 kernel 
sources. I think kernel crash dump could provide here more info.


Thanks
Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
