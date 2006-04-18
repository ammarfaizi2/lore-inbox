Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbWDRMqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWDRMqa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 08:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWDRMqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 08:46:30 -0400
Received: from mail.gmx.de ([213.165.64.20]:61119 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750774AbWDRMq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 08:46:29 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.16.1 & D state processes
From: Mike Galbraith <efault@gmx.de>
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060418093521.41424.qmail@web52610.mail.yahoo.com>
References: <20060418093521.41424.qmail@web52610.mail.yahoo.com>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 14:47:02 +0200
Message-Id: <1145364422.7515.5.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-18 at 19:35 +1000, Srihari Vijayaraghavan wrote:
> --- Mike Galbraith <efault@gmx.de> wrote:
> > On Tue, 2006-04-18 at 15:07 +1000, Srihari
> > Vijayaraghavan wrote:
> > > io scheduler cfq registered (default)
> > ...
> > Hmm.  Recovers [odd] but takes long time [odder]. 
> > I'd try to eliminate
> > io scheduler at this point.
> 
> Interesting. Considering the minimal .config, where I
> haven't experienced this problem over a week uptime,
> also having CFQ as the default elevator, do you still
> believe CFQ is involved? (I guess if CFQ could be
> influenced by other kernel configurations, then
> perhaps another elevator might help. It's worth
> trying.)

I don't know that CFQ is involved.  With it recovering though, the only
thing I could think of was a request stucking in the io scheduler's
gizzard for some reason.

It's just a suggestion, and one you can try without even rebooting.

	-Mike

