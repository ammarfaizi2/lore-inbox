Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271747AbTHDNqf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 09:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271748AbTHDNqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 09:46:35 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:41443 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S271747AbTHDNq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 09:46:29 -0400
Date: Mon, 4 Aug 2003 15:46:28 +0200
From: bert hubert <ahu@ds9a.nl>
To: devik <devik@cdi.cz>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Allow /dev/{,k}mem to be disabled to prevent kernel from being modified easily
Message-ID: <20030804134627.GA32162@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, devik <devik@cdi.cz>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20030803180950.GA11575@outpost.ds9a.nl> <Pine.LNX.4.33.0308041122090.533-100000@devix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0308041122090.533-100000@devix>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 11:37:57AM +0200, devik wrote:

> think about possibility to change syscall table with no previous
> knowledge. I replied with test code which is able to locate syscall table
> and kmalloc routine address using some statistics on /dev/kmem.

(...)
> I want to say that I'm not affiliated with SucKIT nor with cracking
> and rootkiting of servers. I'll try to convince mentioned hacker
> to remove my name from the kit as I'm tired of all the complaints :-(
> 
> If you feel that I'm source of your problems then I'm sorry for it.

Ok - apologies for my needless rant in your direction. I guess I also just
felt bad for not upgrading my kernel in 450 days of uptime, if I did that, I
would not have been rooted in the first place.

Will try to avenge all this by implementing a nice LSM module for preventing
such malware from being able to deploy too easily :-)

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
