Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261372AbSJ1X5T>; Mon, 28 Oct 2002 18:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261388AbSJ1X5T>; Mon, 28 Oct 2002 18:57:19 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:25512 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261372AbSJ1X5S>;
	Mon, 28 Oct 2002 18:57:18 -0500
Date: Tue, 29 Oct 2002 01:03:39 +0100
From: bert hubert <ahu@ds9a.nl>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Davide Libenzi <davidel@xmailserver.org>, Hanna Linder <hannal@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] epoll more scalable than poll
Message-ID: <20021029000339.GA31212@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Jamie Lokier <lk@tantalophile.demon.co.uk>,
	Davide Libenzi <davidel@xmailserver.org>,
	Hanna Linder <hannal@us.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-aio@vger.kernel.org, lse-tech@lists.sourceforge.net
References: <20021028220809.GB27798@outpost.ds9a.nl> <Pine.LNX.4.44.0210281420540.966-100000@blue1.dev.mcafeelabs.com> <20021028234434.GB18415@bjl1.asuk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021028234434.GB18415@bjl1.asuk.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 11:44:34PM +0000, Jamie Lokier wrote:

> :( I was hoping sys_epoll would be scalable without increasing the
> number of system calls per event.

I see only one call per event? sys_epoll_wait. Perhaps sys_epoll_ctl to
register a new interest.

Regards,

bert
-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
