Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288922AbSAXStB>; Thu, 24 Jan 2002 13:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288897AbSAXSsv>; Thu, 24 Jan 2002 13:48:51 -0500
Received: from peebles.phys.ualberta.ca ([129.128.7.18]:21391 "EHLO
	peebles.phys.ualberta.ca") by vger.kernel.org with ESMTP
	id <S288896AbSAXSsj>; Thu, 24 Jan 2002 13:48:39 -0500
Message-ID: <3C505702.7B665083@phys.ualberta.ca>
Date: Thu, 24 Jan 2002 11:48:34 -0700
From: pogosyan@phys.ualberta.ca
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17-0.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: whitney@math.berkeley.edu
CC: Rasmus =?iso-8859-1?Q?B=F8g?= Hansen <moffe@amagerkollegiet.dk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: ACPI trouble (Was: Re: [patch] amd athlon cooling on kt266/266a 
 chipset)
In-Reply-To: <20020124155853Z287177-13996+11274@vger.kernel.org> <Pine.LNX.4.44.0201241803540.1345-100000@grignard.amagerkollegiet.dk> <200201241749.g0OHnbG02468@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Note that on this motherboard (and perhaps all ASUS Via chipset
> motherboards, including the A7V133), one needs the following line in
> /etc/sensors.conf to get reasonable lm_sensors CPU temperatures:
>   compute temp2 @*2, @/2
> This is as described at http://www2.lm-sensors.nu/~lm78/support.html
> in Ticket 775.
>

I have ASUS A7V266-E (AS99127F chip) and lm_sensors 2.6.2
shows 43 C for CPU without any additional lines in /etc/sensors.conf

Which sounds reasonable.   However this temperature is rarely ever change !
I typically have 43.1,   sometimes 42.8   and that's it.   Even after 2-3 min

compiles.    So something is wrong

                Dmitri

