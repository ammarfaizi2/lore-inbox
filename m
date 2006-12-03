Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759674AbWLCNis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759674AbWLCNis (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 08:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759677AbWLCNir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 08:38:47 -0500
Received: from 30.mail-out.ovh.net ([213.186.62.213]:18605 "HELO
	30.mail-out.ovh.net") by vger.kernel.org with SMTP id S1759674AbWLCNiq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 08:38:46 -0500
Date: Sun, 03 Dec 2006 14:21:09 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] - revert generic_fillattr stat->blksize to PAGE_CACHE_SIZE
From: col-pepper@catking.net
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-ID: <op.tjzjdji6q8etvz@linbox.localdomain>
User-Agent: Opera Mail/9.02 (Linux)
X-Ovh-Remote: 90.144.87.8 (d90-144-87-8.cust.tele2.fr)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|H 0.5/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using a 2.6.18.2 based kernel and see lots of broken fs due to this  
"diet". eg cloop

I hope some general lessons can be drawn about the necessity and  
desirablility of such changes that (predictably) invoke broadband breakage.

This kind of change and the breakage and dependancy issues they create are  
what makes linux a nightmare to maintain.

While it seems some improvement and clean up may result from this getting  
attention, it appears that the inode structure is back to it's original  
size. Which is quite probably the way it should have stayed all along.

Hopefully this has now stablised.


What kernel release contains code where all this calms down and I dont  
need to search patches and updates for modules in order to get basics to  
work again?

Alternatively can I simply revert the original diet patch on my 2.6.18.2  
to maintain working fs modules?

Thanks for your replys.

