Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbWE3N2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbWE3N2A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 09:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWE3N2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 09:28:00 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:5470 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751498AbWE3N17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 09:27:59 -0400
Date: Tue, 30 May 2006 15:30:05 +0200
From: Jens Axboe <axboe@suse.de>
To: Mike Galbraith <efault@gmx.de>
Cc: Al Viro <viro@ftp.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc4-mm3 cfq oops->panic w. fs damage
Message-ID: <20060530133004.GZ4199@suse.de>
References: <1148793123.7572.22.camel@homer> <20060528052514.GQ27946@ftp.linux.org.uk> <1148796018.11873.11.camel@homer> <1148802491.8083.7.camel@homer> <1148803384.8757.7.camel@homer> <1148804675.7755.2.camel@homer> <1148900440.9817.46.camel@homer> <20060530123652.GV4199@suse.de> <1148995632.7574.4.camel@homer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148995632.7574.4.camel@homer>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30 2006, Mike Galbraith wrote:
> On Tue, 2006-05-30 at 14:36 +0200, Jens Axboe wrote:
> 
> > I'm suspecting a recent -mm change, since git-cfq hasn't changed in
> > quite a while and it used to work just fine.
> 
> It's apparently not mm.  I just plugged it into 2.6.17-rc4, and get the
> same explosion.  It doesn't seem to play well with the changes in
> 2.6.17-rc1.

Ah, ok that makes sense. I'll take a closer look at it, thanks for
reporting!

-- 
Jens Axboe

