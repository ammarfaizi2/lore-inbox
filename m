Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266662AbRGTHNt>; Fri, 20 Jul 2001 03:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266667AbRGTHNj>; Fri, 20 Jul 2001 03:13:39 -0400
Received: from warp.zuto.de ([194.77.109.75]:42766 "EHLO warp.zuto.de")
	by vger.kernel.org with ESMTP id <S266662AbRGTHNa>;
	Fri, 20 Jul 2001 03:13:30 -0400
From: Rainer Clasen <bj@zuto.de>
Date: Fri, 20 Jul 2001 09:13:29 +0200
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [PATCH] PPPOE can kfree SKB twice (was Re: kernel panic problem. (smp, iptables?))
Message-ID: <20010720091329.B16207@zuto.de>
Reply-To: bj@zuto.de
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
In-Reply-To: <005f01c10e69$28273e60$0200a8c0@loki> <15189.2408.59953.395204@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15189.2408.59953.395204@pizda.ninka.net>; from davem@redhat.com on Tue, Jul 17, 2001 at 08:58:32PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 17, 2001 at 08:58:32PM -0700, David S. Miller wrote:
> Initially we believed it might be some obscure bug in netfilter
> which got triggered more easily when the zerocopy stuff went in.
> But all of our code audits turned up nothing.
> 
> Then I began to notice that "pppoe" was showing up in all the reports
> where the user actually bothered to mention what net devices the
> machine was using when it crashed.

well, I have no PPPoE running and my OOPSen look very similar. (see MsgId
<20010620201648.B12694@zuto.de>).

I am using tulip, dummy, Ben Grear's dot1q VLAN devices and some ISDN
syncppp and ISDN rawip devices are configured (but not actively used),
too.


Rainer

-- 
KeyID=759975BD fingerprint=887A 4BE3 6AB7 EE3C 4AE0  B0E1 0556 E25A 7599 75BD
