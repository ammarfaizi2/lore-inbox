Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264479AbUHWOON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbUHWOON (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 10:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUHWOON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 10:14:13 -0400
Received: from fep02fe.ttnet.net.tr ([212.156.4.132]:6364 "EHLO
	fep02.ttnet.net.tr") by vger.kernel.org with ESMTP id S264479AbUHWOOK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 10:14:10 -0400
Message-ID: <4129FB86.40508@ttnet.net.tr>
Date: Mon, 23 Aug 2004 17:13:26 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] gcc-3.4 more fixes
References: <4129F41A.3070805@ttnet.net.tr> <20040823123430.GD4569@logos.cnet>
In-Reply-To: <20040823123430.GD4569@logos.cnet>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> On Mon, Aug 23, 2004 at 04:41:46PM +0300, O.Sezer wrote:
> 
>>>>Ozkan,
>>>>
>>>>This are just warning fixes right?
>>>>
>>>>I dont like this patches, that is, I'm not confident about them.
>>>>
>>>>Let the warnings be.
>>>
>>>For gcc-3.4 they're warnings. For gcc-3.5 they'll cause compiler
>>>failures (that's what mikpe says on cset-1.1490, too)
>>
>>As a side note, almost all of them are in 2.6 anyway (can't
>>honestly remember which aren't)
> 
> 
> Have you nocited the deadly mistake you made I showed with the grep?
> 

Oopss :/  Than 2.6 has the same deadly thing. I'm too trusting I
guess..  The correct thing should be to change "if (!(PRIV(dev) ="
into "if (!(dev->phy_data =", right?

