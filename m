Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261556AbSJ1V43>; Mon, 28 Oct 2002 16:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261559AbSJ1V43>; Mon, 28 Oct 2002 16:56:29 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:44184 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261556AbSJ1V43>;
	Mon, 28 Oct 2002 16:56:29 -0500
Date: Mon, 28 Oct 2002 23:02:49 +0100
From: bert hubert <ahu@ds9a.nl>
To: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] epoll more scalable than poll
Message-ID: <20021028220249.GA27798@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org
References: <53100000.1035832459@w-hlinder> <20021028205647.GC1402@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021028205647.GC1402@admingilde.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 09:56:47PM +0100, Martin Waitz wrote:

> needing only one syscall per poll while building a changelist in
> userspace...

Which is so smashingly succesful for iptables. I would very much doubt the
utility of building tables in userspace and them blasting them across,
especially as they will tend to be large when people bother to use epoll.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
