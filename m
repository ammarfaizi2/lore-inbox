Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315154AbSDWLBA>; Tue, 23 Apr 2002 07:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315155AbSDWLA7>; Tue, 23 Apr 2002 07:00:59 -0400
Received: from [203.200.51.170] ([203.200.51.170]:33782 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S315154AbSDWLA6>; Tue, 23 Apr 2002 07:00:58 -0400
Message-Id: <200204231112.g3NBCFI18486@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII
From: rpm <rajendra.mishra@timesys.com>
Reply-To: rajendra.mishra@timesys.com
Organization: Timesys
To: Frank Louwers <frank@openminds.be>, linux-kernel@vger.kernel.org
Subject: Re: BUG: 2 NICs on same network
Date: Tue, 23 Apr 2002 16:42:15 +0530
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20020423113935.A30329@openminds.be> <200204231054.g3NArPI18473@localhost.localdomain> <20020423125259.A1322@openminds.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

try  disconnecting eth0 interface ( with eth1 connected )
and then pinging it  eth0 ! 

On Tuesday 23 April 2002 04:22 pm, Frank Louwers wrote:
> On Tue, Apr 23, 2002 at 04:23:25PM +0530, rpm wrote:
> > check the MAC address  of the two cards cards !
>
> Mac addresses are different! (In my first setup the addresses only
> differed 1 bit (server with 2 nics onboard)), but later I tried with 2
> different brand of nics, so they should have been different enough.
>
> > i am also using similar configuration but am not getting any thing like
> > that !
>
> When i disconnect the cable of eth1, and ping it's ip from another
> machine and check the arp table for that machine, I get the mac
> address for eth0 ...
>
>
> Frank
