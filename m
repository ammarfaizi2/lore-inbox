Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315142AbSDWKlk>; Tue, 23 Apr 2002 06:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315145AbSDWKlj>; Tue, 23 Apr 2002 06:41:39 -0400
Received: from [203.200.51.170] ([203.200.51.170]:19446 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S315142AbSDWKli>; Tue, 23 Apr 2002 06:41:38 -0400
Message-Id: <200204231054.g3NArPI18473@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII
From: rpm <rajendra.mishra@timesys.com>
Reply-To: rajendra.mishra@timesys.com
Organization: Timesys
To: Frank Louwers <frank@openminds.be>, linux-kernel@vger.kernel.org
Subject: Re: BUG: 2 NICs on same network
Date: Tue, 23 Apr 2002 16:23:25 +0530
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20020423113935.A30329@openminds.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

check the MAC address  of the two cards cards !  
i am also using similar configuration but am not getting any thing like that !

rpm
On Tuesday 23 April 2002 03:09 pm, Frank Louwers wrote:
> Hi,
>
> We recently stummed across a rather annoying bug when 2 nics are on
> the same network.
>
> Our situation is this: we have a server with 2 nics, each with a
> different IP on the same network, connected to the same switch. Let's
> assume eth0 has ip 1.2.3.1 and eth1 has 1.2.3.2, with a both with a
> netmask of 255.255.255.0.
>
> Now the strange thing is that traffic for 1.2.3.2 arrives at eth0 no
> matter what!
>
> Even if we disconnect the cable for eth1, 1.2.3.2 still replies to
> pings, ssh, web, ...
>
> We tested this on IA32 architecture, different 2.4.x kernels and
> different nics ...
>
> Is this a bug or a known issue? If it is not a bug, how can it be
> solved?
>
> Kind Regards,
> Frank Louwers
