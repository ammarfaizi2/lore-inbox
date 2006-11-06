Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932793AbWKFHwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932793AbWKFHwM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 02:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932795AbWKFHwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 02:52:11 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:62593 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932793AbWKFHwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 02:52:10 -0500
Message-ID: <454EE9A2.4060908@pobox.com>
Date: Mon, 06 Nov 2006 02:52:02 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@redhat.com>, Patrick McHardy <kaber@trash.net>,
       netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/1] Net: kconfig, correct traffic shaper
References: <453BA26D.9010504@trash.net>, <43123154321532@wsc.cz> <1202725131414221392@wsc.cz>
In-Reply-To: <1202725131414221392@wsc.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Patrick McHardy <kaber@trash.net> wrote:
>> While you're at it .. CBQ is actually not a very good alternative
>> since it doesn't work properly on top of virtual network devices.
>> The closest match for an alternative would be TBF, but HTB and
>> HFSC also do fine. Maybe just point to the traffic schedulers in
>> general. I think you could also change EXPERIMENTAL to OBSOLETE
>> for the shaper device, the traffic schedulers are a lot more
>> flexible.
> 
> Ok, thanks for comments. Here it comes, please (n)ack it:
> 
> --
> 
> kconfig, correct traffic shaper
> 
> As Patrick McHardy <kaber@trash.net> suggested, Traffic Shaper is
> now obsolete and alternative to it is no longer CBQ, since its problems with
> virtual devices, alter Kconfig text to reflect this -- put a link to the
> traffic schedulers as a whole.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> Cc: Alan Cox <alan@redhat.com>
> Cc: Patrick McHardy <kaber@trash.net>

ACK from me, though I think that since it relates to traffic schedulers 
I think this patch should be merged through DaveM...

	Jeff


