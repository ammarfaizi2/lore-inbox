Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269016AbUHMHYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269016AbUHMHYU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 03:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269021AbUHMHYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 03:24:19 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:53737 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S269016AbUHMHYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 03:24:10 -0400
Date: Fri, 13 Aug 2004 09:24:07 +0200
From: bert hubert <ahu@ds9a.nl>
To: Florin Andrei <florin@andrei.myip.org>
Cc: linux-kernel@vger.kernel.org
Subject: dvd ripping causing: Re: excessive swapping
Message-ID: <20040813072407.GA26981@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Florin Andrei <florin@andrei.myip.org>, linux-kernel@vger.kernel.org
References: <1092379250.2597.14.camel@rivendell.home.local> <1092379468.2597.16.camel@rivendell.home.local> <1092381036.2597.29.camel@rivendell.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092381036.2597.29.camel@rivendell.home.local>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 12:10:37AM -0700, Florin Andrei wrote:

> I'm sorry for rambling, but to me the current swapping policy is so
> blatantly wrong. Besides the space occupied by the apps themselves,
> there's a lot of room to _spare_ - then why swap?

It is a bug - calm down. It has been reported before but now quite hammered
down yet.

Can you report the files I asked you for? Could you also try:
echo 0 > /proc/sys/vm/swappiness 

Thanks.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
