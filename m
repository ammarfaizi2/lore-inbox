Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135250AbRDRSsv>; Wed, 18 Apr 2001 14:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135249AbRDRSsr>; Wed, 18 Apr 2001 14:48:47 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:38660 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S135254AbRDRSsU>;
	Wed, 18 Apr 2001 14:48:20 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Shawn <z3rk@ahkbarr.dynip.com>
Date: Wed, 18 Apr 2001 20:47:17 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Coping with removal of skb_dataref
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <78704B4246@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Apr 01 at 13:11, Shawn wrote:

> Ever since the changes to skb_dataref happened,
> The following snippit needs to be changed.
> 
> #  define SKB_IS_CLONE_OF(clone, skb)   ( \
>       skb_dataref(clone) == skb_dataref(skb) \
>    )

It is from VMware, so best place would be news server
news.vmware.com. Pointer to patch is resent there 
almost daily, as VMware users are not able to search 
newsgroups (server supports it, but users do not), so 
just join and read all messages from any day ;-) Just 
replace skb_datarefp with skb_shinfo. You can found 
details at:

NNTP-Host: news.vmware.com
From: Petr Vandrovec <vandrove@vc.cvut.cz>
Newsgroups: vmware.for-linux.installation
Subject: Re: vmnet and 2.4.2-ac4 compile error. Fix here.
Date: Mon, 26 Feb 2001 21:14:47 +0100
Message-ID: <3A9AB937.AC84BF58@vc.cvut.cz>

                                        Petr Vandrovec
                                        vandrove@vc.cvut.cz
                                        
