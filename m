Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbWD0Phw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbWD0Phw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 11:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbWD0Phw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 11:37:52 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:33165 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1030192AbWD0Phv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 11:37:51 -0400
Date: Thu, 27 Apr 2006 19:37:38 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH -mm] W1_CON: add W1 to depends
Message-ID: <20060427153738.GA31564@2ka.mipt.ru>
References: <20060426212131.1c566d19.rdunlap@xenotime.net> <20060427125745.GA12840@2ka.mipt.ru> <20060427082525.4b1ee4db.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060427082525.4b1ee4db.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 27 Apr 2006 19:37:39 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2006 at 08:25:25AM -0700, Randy.Dunlap (rdunlap@xenotime.net) wrote:
> On Thu, 27 Apr 2006 16:57:45 +0400 Evgeniy Polyakov wrote:
> 
> > On Wed, Apr 26, 2006 at 09:21:31PM -0700, Randy.Dunlap (rdunlap@xenotime.net) wrote:
> > > From: Randy Dunlap <rdunlap@xenotime.net>
> > > 
> > > W1_CON should depend on W1 also.
> > 
> > I have no problem with the patch, but does dependency absence introduce
> > some problems? This config option is only used when w1 is enabled.
> 
> Not quite true, or I wouldn't have seen a problem and sent a patch
> for it.
> With W1 disabled and doing 'make oldconfig', I got a prompt for
> 
>   Userspace communication over connector (W1_CON)? [Y/m/n]
> 
> which shouldn't happen.

I mean that it is asked to be enabled or not, but some compilation and
other logic is only turned on when w1 is enabled.

But you are right, it should not appear if w1 is not enabled.
I will take care of your patch, thank you, Randy.

> ---
> ~Randy

-- 
	Evgeniy Polyakov
