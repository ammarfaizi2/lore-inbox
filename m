Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265191AbTLFPKr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 10:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265192AbTLFPKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 10:10:47 -0500
Received: from pop.gmx.net ([213.165.64.20]:18837 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265191AbTLFPKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 10:10:46 -0500
X-Authenticated: #4512188
Message-ID: <3FD1F172.2070601@gmx.de>
Date: Sat, 06 Dec 2003 16:10:42 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>, cheuche+lkml@free.fr,
       linux-kernel@vger.kernel.org, Allen Martin <AMartin@nvidia.com>
Subject: Re: [PATCH] Re: Catching NForce2 lockup with NMI watchdog - found
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F87E@mail-sc-6.nvidia.com> <20031206081848.GA4023@localnet> <3FD1CA81.9010708@gmx.de> <200312061411.37795.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200312061411.37795.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> It is possible :-).  Here is a completly untested patch.
> 
> [PATCH] fix lockups with APIC support on nForce2


I tried it (applied pacth and *enabled* CPU disconnect in bios) and it 
works! Good work. Nevertheless, it is no real fix, just a work-around. 
Perhaps somone from nvidia should comment on this...or some APIC guru 
needs to take a look into the code.

Prakash

