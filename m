Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269012AbUHMHKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269012AbUHMHKr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 03:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269013AbUHMHKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 03:10:46 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:33513 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S269012AbUHMHKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 03:10:45 -0400
Date: Fri, 13 Aug 2004 09:10:44 +0200
From: bert hubert <ahu@ds9a.nl>
To: Florin Andrei <florin@andrei.myip.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: excessive swapping
Message-ID: <20040813071044.GA10988@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Florin Andrei <florin@andrei.myip.org>, linux-kernel@vger.kernel.org
References: <1092379250.2597.14.camel@rivendell.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092379250.2597.14.camel@rivendell.home.local>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 11:40:51PM -0700, Florin Andrei wrote:
> I am running 2.6.8-rc4 with Ingo's voluntary preempt patch O5, on Fedora
> 2.
> I'm using the default Gnome environment, reading mail with Evolution,
> browsing with Firefox, etc. I've 512MB of RAM.

Please see if you can reproduce this behaviour without any additional
patches. Furthermore, when this has happened, please show the output of cat
/proc/meminfo and cat /proc/slabinfo and your .config.

> The system is swapping excessively. There's no way the total size of the
> applications exceeds the size of RAM. There's plenty of room to spare,
> yet 16% of the 530MB of swap is used.

Please show a few lines of vmstat 1 when this happens.

Thanks!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
