Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262617AbSKBOAY>; Sat, 2 Nov 2002 09:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265973AbSKBOAY>; Sat, 2 Nov 2002 09:00:24 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:36553 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S262617AbSKBOAX>;
	Sat, 2 Nov 2002 09:00:23 -0500
Date: Sat, 2 Nov 2002 15:06:53 +0100
From: bert hubert <ahu@ds9a.nl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: davidel@xmailserver.org
Subject: Re: [patch] total-epoll ( aka full epoll support for poll() enabled devices ) ...
Message-ID: <20021102140653.GA3528@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	davidel@xmailserver.org
References: <Pine.LNX.4.44.0211011940010.1443-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211011940010.1443-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 09:13:13PM -0800, Davide Libenzi wrote:

> *) Multi-thread support. The wait interface is changed to :
> 
> 	int epoll_wait(int epfd, struct pollfd *events, int maxevents,
>                        int timeout);

This means that userspace has to allocate I understand?

> *) Yes, ... it drops an event @ EP_CTL_ADD :)

Thank you :-)

> The patch is working fine on my machine but it's very new code.
> Comments and test reports will be very welcome ...

I'll test. Do you want me to update the manpages to reflect the changes
above?

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
