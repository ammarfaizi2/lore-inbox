Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWE1IBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWE1IBN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 04:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWE1IBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 04:01:13 -0400
Received: from mail.gmx.de ([213.165.64.20]:8163 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932079AbWE1IBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 04:01:12 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.17-rc4-mm3 cfq oops->panic w. fs damage
From: Mike Galbraith <efault@gmx.de>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
In-Reply-To: <1148802491.8083.7.camel@homer>
References: <1148793123.7572.22.camel@homer>
	 <20060528052514.GQ27946@ftp.linux.org.uk> <1148796018.11873.11.camel@homer>
	 <1148802491.8083.7.camel@homer>
Content-Type: text/plain
Date: Sun, 28 May 2006 10:03:04 +0200
Message-Id: <1148803384.8757.7.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-28 at 09:48 +0200, Mike Galbraith wrote:
> On Sun, 2006-05-28 at 08:00 +0200, Mike Galbraith wrote:
> > On Sun, 2006-05-28 at 06:25 +0100, Al Viro wrote:
> > > On Sun, May 28, 2006 at 07:12:03AM +0200, Mike Galbraith wrote:
> > > > Greetings,
> > > > 
> > > > I tried to boot 2.6.17-rc4-mm3 twice yesterday, and received the below
> > > > both times.  Both times, the oops->panic occurred while X/KDE was
> > > > starting.  KDE would not run thereafter, and had to be reinstalled.
> > > 
> > > Can you reproduce that with mainline?
> > 
> > Virgin rc4 has been working fine, but I've been using UP kernels.  I'll
> > try the same config as SMP.
> 
> She's running fine.  Guess I'll go prod mm3 again.

Yup, mm3 makes reliable kaboom.

I suppose the first thing to do is see if it's cfq, and then maybe toss
a dart at the patch list.

	-Mike

