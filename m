Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267598AbUHWWWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267598AbUHWWWk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 18:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267628AbUHWWUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 18:20:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49124 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267598AbUHWWSh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 18:18:37 -0400
Message-ID: <412A6D2F.1030704@pobox.com>
Date: Mon, 23 Aug 2004 18:18:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: "O.Sezer" <sezeroz@ttnet.net.tr>, linux-kernel@vger.kernel.org,
       davem@redhat.com
Subject: Re: [PATCH 2.4] gcc-3.4 more fixes
References: <4129F41A.3070805@ttnet.net.tr> <20040823123430.GD4569@logos.cnet> <4129FB86.40508@ttnet.net.tr> <20040823131137.GA1779@logos.cnet>
In-Reply-To: <20040823131137.GA1779@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> On Mon, Aug 23, 2004 at 05:13:26PM +0300, O.Sezer wrote:
> 
>>Marcelo Tosatti wrote:
>>
>>>On Mon, Aug 23, 2004 at 04:41:46PM +0300, O.Sezer wrote:
>>>
>>>
>>>>>>Ozkan,
>>>>>>
>>>>>>This are just warning fixes right?
>>>>>>
>>>>>>I dont like this patches, that is, I'm not confident about them.
>>>>>>
>>>>>>Let the warnings be.
>>>>>
>>>>>For gcc-3.4 they're warnings. For gcc-3.5 they'll cause compiler
>>>>>failures (that's what mikpe says on cset-1.1490, too)
>>>>
>>>>As a side note, almost all of them are in 2.6 anyway (can't
>>>>honestly remember which aren't)
>>>
>>>
>>>Have you nocited the deadly mistake you made I showed with the grep?
>>>
>>
>>Oopss :/  Than 2.6 has the same deadly thing. I'm too trusting I
>>guess..  The correct thing should be to change "if (!(PRIV(dev) ="
>>into "if (!(dev->phy_data =", right?
> 
> 
> I think so yes. A network driver expert can confirm this for us.


Not enough context is quoted for me to decipher what this refers to :(

URL?

	Jeff


