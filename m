Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWGCQ1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWGCQ1w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 12:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWGCQ1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 12:27:52 -0400
Received: from gw.goop.org ([64.81.55.164]:10904 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750711AbWGCQ1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 12:27:52 -0400
Message-ID: <44A9459E.9070303@goop.org>
Date: Mon, 03 Jul 2006 09:28:14 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Andy Gay <andy@andynet.net>
CC: Roland Dreier <rdreier@cisco.com>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       Ken Brush <kbrush@gmail.com>
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO
 transfers
References: <1151646482.3285.410.camel@tahini.andynet.net>	<adad5cnderb.fsf@cisco.com> <1151872141.3285.486.camel@tahini.andynet.net>	<44A8C0AB.3070904@goop.org> <1151936484.3285.497.camel@tahini.andynet.net>
In-Reply-To: <1151936484.3285.497.camel@tahini.andynet.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Gay wrote:
>> I think if the hardware has the EPs, they should be exposed by the 
>> driver.  You can tweak usermode as to whether they get device nodes, 
>> what they're called, etc.
>>     
> I tend to agree. I'm thinking for now I should leave it as is, so it
> defaults to configuring 3 EPs. Perhaps later I'll try to collect #EP
> info for all the supported devices.
>   

Why not just expose all the EPs the hardware presents?  Is there a 
chance they might not be a serial connection?

> This is curious. I saw that '0218' in Greg's code, and 'corrected' it to
> 0018, because here's what I get with my MC5720:
>   

Yes, that patch was from me.

> P:  Vendor=1199 ProdID=0018 Rev= 0.01
> S:  Manufacturer=Sierra Wireless
> S:  Product=Sierra Wireless MC5720 Modem
>
> So evidently there are also multiple variants of each modem.
>   
My came embedded in a Thinkpad X60, and I think it is locked to 
Verizon.  The product ID might reflect either or both of those states.

    J
