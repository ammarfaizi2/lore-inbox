Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266607AbUGKWSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266607AbUGKWSU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 18:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266630AbUGKWSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 18:18:20 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:28059 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S266607AbUGKWST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 18:18:19 -0400
Date: Mon, 12 Jul 2004 00:18:18 +0200
From: bert hubert <ahu@ds9a.nl>
To: Sid Boyce <sboyce@blueyonder.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.x Scheduler, preemption and responsiveness - puzzlement
Message-ID: <20040711221818.GA30704@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Sid Boyce <sboyce@blueyonder.co.uk>, linux-kernel@vger.kernel.org
References: <40F1BA46.9000207@blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F1BA46.9000207@blueyonder.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2004 at 11:08:06PM +0100, Sid Boyce wrote:
> With the 2.6 kernel I expected that my boxes would be responsive under 
> heavy loads such as exacted by updatedb. What I'm finding is that when 
> updatedb and other heavy hitters are running, I'm often unable to switch 
> desktops or start other tasks. I'm currently using 2.6.7-mm1, but this 

Can you run vmstat 1 while this happens? Can you make your .config
available?

Output of dmesg during boot would also be great. Especially check the output
of hdparm /dev/hda - DMA might be off.

Good luck!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
