Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267828AbUIPIKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267828AbUIPIKw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 04:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267829AbUIPIKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 04:10:51 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16907 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S267828AbUIPIKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 04:10:49 -0400
Date: Thu, 16 Sep 2004 10:10:17 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "Randy.Dunlap" <randy.dunlap@verizon.net>
Cc: mgreer@mvista.com, akpm <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: review MPSC driver
Message-ID: <20040916081017.GA2167@fs.tum.de>
References: <20040915150247.37706f7c.rddunlap@osdl.org> <20040915214301.53a68379.randy.dunlap@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915214301.53a68379.randy.dunlap@verizon.net>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 09:43:01PM -0700, Randy.Dunlap wrote:
> 
> | http://www.uwsg.iu.edu/hypermail/linux/kernel/0408.3/1549.html
> 
> Hi Mark,
>...
> 3.  + select SERIAL_CORE
>     + select SERIAL_CORE_CONSOLE
> 
> Please don't use "select".  Use "depends on" instead.
>...

That's a silly suggestion since none of these options are user visible.

> ~Randy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

