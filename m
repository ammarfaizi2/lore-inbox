Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278119AbRJRUIc>; Thu, 18 Oct 2001 16:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278118AbRJRUIQ>; Thu, 18 Oct 2001 16:08:16 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:50629 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S277868AbRJRUGa>; Thu, 18 Oct 2001 16:06:30 -0400
Message-ID: <3BCF36BE.DE10E221@nortelnetworks.com>
Date: Thu, 18 Oct 2001 16:08:30 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: how to see manually specified proxy arp entries using "ip neigh"
In-Reply-To: <200110181925.XAA04814@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:

> > I (and others) have asked this a couple times here and on the netdev list, and
> > so far nobody has answered it (not even negatively).
> 
> :-) And me answered to this hundred of times: "no way". :-)

Whee, an answer!

> Ability to add/delete them with "ip neigh" will be removed in the next
> snapshot as well. The feature is obsolete.

Oh?  Let me present a scenario in which I use it and then you can tell me how
better to do it.

I'm using the ethertap device (in 2.2, tun/tap in 2.4 should be similar) to pass
stuff up to userspace. I have an ethernet link.  I want the kernel to proxy arp
for the ip address assigned to the ethertap device with the mac address of the
NIC, without enabling proxy arping for any other addresses.

Currently I have been doing this by manually setting proxy arping on the NIC for
the IP address assigned to the ethertap device.  If this feature is going to be
removed, then how should I be doing this?

Thanks,

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
