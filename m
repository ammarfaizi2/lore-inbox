Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261910AbSJ2PND>; Tue, 29 Oct 2002 10:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261911AbSJ2PNC>; Tue, 29 Oct 2002 10:13:02 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:57567 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261910AbSJ2PNB>;
	Tue, 29 Oct 2002 10:13:01 -0500
Date: Tue, 29 Oct 2002 16:19:23 +0100
From: bert hubert <ahu@ds9a.nl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
Message-ID: <20021029151923.GA16263@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3DBDCC02.6060100@netscape.com> <Pine.LNX.4.44.0210281606390.966-100000@blue1.dev.mcafeelabs.com> <20021029125904.GA6840@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021029125904.GA6840@admingilde.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2002 at 01:59:04PM +0100, Martin Waitz wrote:

> every api should be build to cause the least astonishment to its users.
> epoll is much more scalable than standard poll, yet i don't think
> it's a nice api.

epoll is not a 'faster poll()'. It is edge based instead of level based -
some astonishment is in order here. Anyhow, all problems with the API
mentioned go away if epoll_ctl() inserts an egde if it finds that its poll
condition is met.

> the unified event mechanism introduced in bsd is a good example imho.
> we should build something that is similar useful for applications.

Sounds 2.7-ish. 

Regards,

bert 

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
