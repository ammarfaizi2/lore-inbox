Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283379AbRK2ShZ>; Thu, 29 Nov 2001 13:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283381AbRK2ShQ>; Thu, 29 Nov 2001 13:37:16 -0500
Received: from host-21.50by.nyc.onsiteaccess.net ([216.89.84.21]:43533 "EHLO
	mailessentials.wagweb.com") by vger.kernel.org with ESMTP
	id <S283379AbRK2ShH>; Thu, 29 Nov 2001 13:37:07 -0500
Message-ID: <3C06805D.7D7AE45A@wagweb.com>
Date: Thu, 29 Nov 2001 13:37:17 -0500
From: Madhav Diwan <mdiwan@wagweb.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Doug McNaught <doug@wireboard.com>
CC: Rajasekhar Inguva <irajasek@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Routing table problems
In-Reply-To: <OFAC45A406.7118A3A7-ON65256B31.00430A0D@in.ibm.com> <m3snaxledv.fsf@belphigor.mcnaught.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Nov 2001 18:38:33.0390 (UTC) FILETIME=[0C755CE0:01C17905]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Use the ifdown and ifup commands instead .. your default routes will
return

 read the scripts in /etc/sysconfig/network-scripts/ for more info.

Madhav Diwan



Doug McNaught wrote:
> 
> "Rajasekhar Inguva" <irajasek@in.ibm.com> writes:
> 
> > Hi All, In continuation to my earlier report ...
> >
> > The problem is only seen with the default gateway entry.
> >
> > The gateway entry for my subnet is also deleted during a 'down', but is
> > restored properly after an 'up' .
> 
> The default gateway route is installed at boot time by a separate
> 'route' command.  'ifconfig' can derive your subnet route from the
> address and mask of the interface, but it can't magically determine
> your default gateway.  Add it yourself using "route" or "ip" or rerun
> your network start scripts.
> 
> In short, "Working as Designed".
> 
> -Doug
> --
> Let us cross over the river, and rest under the shade of the trees.
>    --T. J. Jackson, 1863
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
