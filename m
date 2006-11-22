Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756319AbWKVVBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756319AbWKVVBm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 16:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756357AbWKVVBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 16:01:41 -0500
Received: from aun.it.uu.se ([130.238.12.36]:10467 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1756311AbWKVVBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 16:01:41 -0500
Date: Wed, 22 Nov 2006 22:00:30 +0100 (MET)
Message-Id: <200611222100.kAML0UtV010405@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: jeff@garzik.org, mikpe@it.uu.se
Subject: Re: [PATCH 2.6.19-rc6] sata_promise updates
Cc: akpm@osdl.org, davem@davemloft.net, htejun@gmail.com,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006 16:17:18 -0500, Jeff Garzik wrote:
>And......  is there any chance you could be talked into working on these 
>sata_promise to-dos:
>
>* conversion to new error handling system (grep for 'freeze', 'thaw', 
>'error_handler', replaces 'phy_reset' and 'eng_timeout')
>
>* support for ATAPI devices (just need to set up ATAPI commands via the 
>packet format described in the public docs)
>
>* support for command queueing
>
>Command queueing is the most involved task, the others should be 
>reasonably straightforward.

I can try, but be warned that I have near-zero experience with ATA
programming. I'll look into new_eh first, and then maybe ATAPI.
NCQ most likely requires someone who understands ATA better than me.

/Mikael
