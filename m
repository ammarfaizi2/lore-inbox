Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751550AbWHKGD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbWHKGD1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 02:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbWHKGD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 02:03:27 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:29584 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750964AbWHKGDZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 02:03:25 -0400
Date: Fri, 11 Aug 2006 07:57:27 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jeff Mahoney <jeffm@suse.com>
cc: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] sector_t format string
In-Reply-To: <44DB945F.5080102@suse.com>
Message-ID: <Pine.LNX.4.61.0608110757090.21588@yvahk01.tjqt.qr>
References: <1155172843.3161.81.camel@localhost.localdomain>
 <20060809234019.c8a730e3.akpm@osdl.org> <20060810191747.GL20581@ca-server1.us.oracle.com>
 <20060810194440.GA6845@martell.zuzino.mipt.ru> <44DB945F.5080102@suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Will
>> 
>> 	printk("%S", sector_t);
>> 
>> kill at least one kitten?
>
>I like the general idea. I think that having to cast every time you want
>to print a sector number is pretty gross. I had something more like %Su
>in mind, though.

What will happen if you run out of %[a-z] ?


Jan Engelhardt
-- 
