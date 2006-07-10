Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWGJJIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWGJJIm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 05:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWGJJIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 05:08:42 -0400
Received: from mail.gmx.net ([213.165.64.21]:27610 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751377AbWGJJIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 05:08:41 -0400
Cc: lcapitulino@mandriva.com.br, vendor-sec@lst.de,
       linux-kernel@vger.kernel.org, akpm@osdl.org, michael.kerrisk@gmx.net
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 10 Jul 2006 11:08:40 +0200
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
In-Reply-To: <20060710090635.GM4141@suse.de>
Message-ID: <20060710090840.109300@gmx.net>
MIME-Version: 1.0
References: <20060709111629.GV4188@suse.de>
 <20060709134703.0aa5bc41@home.brethil> <20060709175744.GZ4188@suse.de>
 <20060710062551.307040@gmx.net> <20060710064355.GB4141@suse.de>
 <20060710080917.286970@gmx.net> <20060710082423.GI4141@suse.de>
 <20060710084017.109310@gmx.net> <20060710084645.GJ4141@suse.de>
 <20060710085025.109290@gmx.net> <20060710090635.GM4141@suse.de>
Subject: Re: splice/tee bugs?
To: Jens Axboe <axboe@suse.de>
X-Authenticated: #24879014
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm duh, the one-in-five-runs should have run a bell (and I should have
> read the trace more carefully) - it's the access times being synced to
> disk. If you mount with noatime,nodiratime you should get consistent
> times across runs.
> 
> So nothing unexpected there.

Thanks.  I was wondering if it was something like this.

Cheers,

Michael
-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  
Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/, 
read the HOWTOHELP file and grep the source 
files for 'FIXME'.
