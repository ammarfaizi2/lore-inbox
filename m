Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263196AbVFWIT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263196AbVFWIT2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbVFWIJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:09:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6608 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262288AbVFWGiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:38:46 -0400
Date: Wed, 22 Jun 2005 23:37:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mike Bell <kernel@mikebell.org>
Cc: miles@gnu.org, greg@kroah.com, gregkh@suse.de, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
Message-Id: <20050622233759.7a1130a9.akpm@osdl.org>
In-Reply-To: <20050623063457.GB955@mikebell.org>
References: <20050621062926.GB15062@kroah.com>
	<20050620235403.45bf9613.akpm@osdl.org>
	<20050621151019.GA19666@kroah.com>
	<20050623010031.GB17453@mikebell.org>
	<20050623045959.GB10386@kroah.com>
	<buoaclhwqfj.fsf@mctpc71.ucom.lsi.nec.co.jp>
	<20050623063457.GB955@mikebell.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Bell <kernel@mikebell.org> wrote:
>
> On Thu, Jun 23, 2005 at 03:14:08PM +0900, Miles Bader wrote:
> > BTW, has anyone done a comparison of the space usage of udev vs. devfs
> > (including size of code etc....)?
> 
> Greg gave me an "I assume so" estimate that udev was smaller by excluding
> the size of sysfs a while back. If you include sysfs in udev's overhead
> then I believe devfs wins handily, but I haven't done the numbers to
> prove it so my estimate is no better. I'm just basing it on sysfs being
> absolutely huge, in linux-tiny terms.

sysfs certainly has a history of goggling gobs of memory.  But you can
disable it in .config.
