Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315485AbSILMiJ>; Thu, 12 Sep 2002 08:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315491AbSILMiI>; Thu, 12 Sep 2002 08:38:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:55213 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315485AbSILMiH>;
	Thu, 12 Sep 2002 08:38:07 -0400
Date: Thu, 12 Sep 2002 14:42:47 +0200
From: Jens Axboe <axboe@suse.de>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 34-mm2 ide problems - unexpected interrupt
Message-ID: <20020912124247.GA11471@suse.de>
References: <200209120838.44092.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209120838.44092.tomlins@cam.org>
User-Agent: Mutt/1.4i
X-OS: Linux 2.4.19-pre8 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12 2002, Ed Tomlinson wrote:
> Hi,
> 
> Got this booting 34-mm2.  Think the are problems with the ide updates...
> UP no preempth.  Everything look ok up to the int loop.

just delete the printk from ide.c:ide_intr(), it's not useful on adapters
with shared interrupts. patch has already been sent to Linus.

feedback on success/problems with 34-mm2 (it seems to include bk patches
up until now?) ide would also be appreciated.

Jens

