Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbWIQRHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbWIQRHi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 13:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbWIQRHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 13:07:38 -0400
Received: from mail.gmx.de ([213.165.64.20]:46828 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965029AbWIQRHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 13:07:37 -0400
X-Authenticated: #14349625
Subject: Re: Scheduler tunables?
From: Mike Galbraith <efault@gmx.de>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <450D6786.7010404@comcast.net>
References: <450C8680.6050904@comcast.net>
	 <1158483845.6025.22.camel@Homer.simpson.net> <450D6786.7010404@comcast.net>
Content-Type: text/plain
Date: Sun, 17 Sep 2006 19:19:05 +0000
Message-Id: <1158520745.6086.6.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-17 at 11:19 -0400, John Richard Moser wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> 
> Mike Galbraith wrote:
> > On Sat, 2006-09-16 at 19:19 -0400, John Richard Moser wrote:
> >> -----BEGIN PGP SIGNED MESSAGE-----
> >> Hash: SHA1
> >>
> >> It looks like the scheduler tunables have been removed from 2.6
> >> somewhere before 2.6.17. 
> > 
> > Which tunables are you referring to?
> > 
> > 
> 
> http://kerneltrap.org/node/525
> 
> The relevant code changes in sysctl.h and sched.c seem to be undone.  Of
> course I'm assuming my distribution didn't just add a side patch in at
> the time when I noticed these existed so long ago.

Ah.  These knobs were never exported in a standard kernel.  I believe
there was a patch recently (couple weeks ago?) posted to export them
again for experimentation.  A search of the archives should turn it up.

	-Mike

