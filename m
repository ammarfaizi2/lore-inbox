Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270270AbTGMQaS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 12:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270271AbTGMQaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 12:30:18 -0400
Received: from www.wireboard.com ([216.151.155.101]:60033 "EHLO
	varsoon.wireboard.com") by vger.kernel.org with ESMTP
	id S270270AbTGMQaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 12:30:15 -0400
To: Chris Morgan <cmorgan@alum.wpi.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.XX very sluggish
References: <200307131228.00155.cmorgan@alum.wpi.edu>
From: Doug McNaught <doug@mcnaught.org>
Date: 13 Jul 2003 12:45:00 -0400
In-Reply-To: Chris Morgan's message of "Sun, 13 Jul 2003 12:28:00 -0400"
Message-ID: <m38yr2e5pv.fsf@varsoon.wireboard.com>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Morgan <cmorgan@alum.wpi.edu> writes:

> 1.4Ghz Athlon via 82cxx chipset, software raid 1 scsi drives, currently 
> running 2.4.21
> 
> With 2.5.73/74/75(the only ones I've tried thus far) the kernel boots fine 
> until it tries to mount the reiserfs partition on the raid1 set.  Replaying 
> the journal takes many times longer than with 2.4.  Once it gets past that 
> point the whole machine appears to be quite sluggish.  Is this a known issue 
> with reiserfs + software raid 1?  What information would be useful to aid in 
> debugging?

What does 'hdparm' say about DMA settings on your drive under 2.5?

-Doug
