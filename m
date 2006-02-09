Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422771AbWBICKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422771AbWBICKZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 21:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422773AbWBICKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 21:10:25 -0500
Received: from xproxy.gmail.com ([66.249.82.203]:34699 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422770AbWBICKY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 21:10:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UNFqZLFQ8C/I2jlf3Li7+sjHuCKsDs8lC7Ds/f6Jum3lv3f/nwL15IGvrYqUaR7n/Zp+jVkt8PeAJTgj/mGoLAvIaEiMJDVP7Y/B4IZOLp4FfKe327VC841zAvnAl4bjL6fG1800UuD6FuyEzRUIEJALvNvhf3+NdPblRtTCrQw=
Message-ID: <4807377b0602081810l55e4cbdfyeb9102bd50d04641@mail.gmail.com>
Date: Wed, 8 Feb 2006 18:10:21 -0800
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: KERNEL: assertion (!sk->sk_forward_alloc) failed
Cc: yoseph.basri@gmail.com, bb@kernelpanic.ru, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20060208.141205.129707967.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <e282236e0602070146p1ed3fdb6k74aa75e15bbc37a3@mail.gmail.com>
	 <4807377b0602081207s7604eceahb8bf4af6715a6534@mail.gmail.com>
	 <20060208.141205.129707967.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/06, David S. Miller <davem@davemloft.net> wrote:
> From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
> Date: Wed, 8 Feb 2006 12:07:14 -0800
>
> > this should be on netdev (cc'd), i included some of the thread here.
>  ...
> > I though Herbert had fixed these, and it looks like half the patches
> > got into 2.6.14.3, but not the fix to the fix committed on 9-6 (not in
> > 2.6.14.* at all)
>
> What are the changeset IDs so I can fix this?

I think the commit id that is missing from 2.6.14.X is
fb5f5e6e0cebd574be737334671d1aa8f170d5f3

but here is the web link if i gave the wrong info
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=fb5f5e6e0cebd574be737334671d1aa8f170d5f3
