Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbULTXA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbULTXA3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 18:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbULTW7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 17:59:05 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:5545 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261677AbULTW6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 17:58:10 -0500
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
From: Lee Revell <rlrevell@joe-job.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Dan Dennedy <dan@dennedy.org>, Ben Collins <bcollins@debian.org>,
       Linux1394-Devel <linux1394-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041220225324.GY21288@stusta.de>
References: <20041220015320.GO21288@stusta.de>
	 <1103508610.3724.69.camel@kino.dennedy.org>
	 <20041220022503.GT21288@stusta.de>
	 <1103510535.1252.18.camel@krustophenia.net>
	 <1103516870.3724.103.camel@kino.dennedy.org>
	 <20041220225324.GY21288@stusta.de>
Content-Type: text/plain
Date: Mon, 20 Dec 2004 17:58:06 -0500
Message-Id: <1103583486.1252.102.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-20 at 23:53 +0100, Adrian Bunk wrote:
> On Sun, Dec 19, 2004 at 11:27:50PM -0500, Dan Dennedy wrote:
> > On Sun, 2004-12-19 at 21:42 -0500, Lee Revell wrote:
> > > What do you tell a vendor who wants to write a driver for their device?
> > > "OK, about half the functions you need are in the kernel, the other half
> > > you have to port from this old kernel because we removed them.  Maybe we
> > > will put them back if we really like your driver"?
> > 
> > While I think some of Adrian's points are valid, I am exercising caution
> > because I am a new maintainer for linux1394 (although not new to the
> > project in general). This is an interface version management issue IMHO.
> > Adrian is not suggesting to remove the functions yet, but it is
> > effectively the same thing to an outsider. A vendor or services provider
> > would have to modify kernel source to let their driver work again, which
> > is not technically challenging to kernel hackers, but frustrating
> > situation to be in as a vendor or customer. It creates a mess in
> > support, distribution, deployment, etc.
> 
> The solution is simple:
> The vendor or services provider submits his driver for inclusion into 
> the kernel which is the best solution for everyone.
> 

What if the driver is under development and doesn't work yet?

Lee

