Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264182AbUFVPHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264182AbUFVPHa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 11:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264229AbUFVPA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:00:29 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:58296 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264530AbUFVOyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 10:54:31 -0400
Message-ID: <40D847E3.2080109@nortelnetworks.com>
Date: Tue, 22 Jun 2004 10:53:23 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, kernel@nn7.de,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       netdev@oss.sgi.com, jgarzik@pobox.com
Subject: Re: sungem - ifconfig eth0 mtu 1300 -> oops
References: <20040621141144.119be627.davem@redhat.com>
In-Reply-To: <20040621141144.119be627.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Mon, 21 Jun 2004 23:03:16 +1000
> Herbert Xu <herbert@gondor.apana.org.au> wrote:
> 
>  > On Mon, Jun 21, 2004 at 10:33:50PM +1000, Herbert Xu wrote:
>  > >
>  > > Does this patch fix your problems?
>  >
>  > Oops, I had a thinko about min vs. max.  I've also decided to make the
>  > bigger MTU useful by adjusting the arguments to skb_put() as well.
>  > Please try this one instead.
> 
> Applied, thanks Herbert.

Just a quick question.  Does the sungem chip support jumbo frames?  I'd like to 
use MTU of 9000 to make large local transfers more efficient, but it didn't seem 
to work last time I checked.

Thanks,

Chris
