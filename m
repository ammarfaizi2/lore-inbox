Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965241AbWIER5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965241AbWIER5r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 13:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965242AbWIER5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 13:57:47 -0400
Received: from khc.piap.pl ([195.187.100.11]:1702 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S965241AbWIER5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 13:57:46 -0400
To: Grant Coady <gcoady.lk@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Jeff Garzik <jeff@garzik.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: PATA drivers queued for 2.6.19
References: <44FC0779.9030405@garzik.org>
	<po4of2pnhpc0325kqj2hd37b7eh3epcdsm@4ax.com>
	<Pine.LNX.4.61.0609041406140.21005@yvahk01.tjqt.qr>
	<44FD7B1E.7020102@aitel.hist.no>
	<1157467176.9018.48.camel@localhost.localdomain>
	<b9arf2lrbh5v4pv9klbtujfhvq3hiuehdk@4ax.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 05 Sep 2006 19:57:34 +0200
In-Reply-To: <b9arf2lrbh5v4pv9klbtujfhvq3hiuehdk@4ax.com> (Grant Coady's message of "Wed, 06 Sep 2006 02:51:56 +1000")
Message-ID: <m3veo2b3ht.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Coady <gcoady.lk@gmail.com> writes:

> Which leads back to this slackware user, who's never used an initrd, 
> thinking about dual root partitions just to get the name change from 
> another /etc/fstab?  

I think it's unnecessary, /etc/fstab is not used while mounting root fs,
and both mount and fsck should understand labels (i.e., you can put
labels there, even for root fs).
-- 
Krzysztof Halasa
