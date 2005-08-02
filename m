Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVHBVun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVHBVun (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 17:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVHBVun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 17:50:43 -0400
Received: from tim.rpsys.net ([194.106.48.114]:27321 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261785AbVHBVuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 17:50:35 -0400
Subject: Re: Where is place of arch independed companion chips?
From: Richard Purdie <rpurdie@rpsys.net>
To: Greg KH <gregkh@suse.de>
Cc: Jamey Hicks <jamey.hicks@hp.com>, Andrey Volkov <avolkov@varma-el.com>,
       linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050801181357.GA31144@suse.de>
References: <42EB6A12.70100@varma-el.com> <42EE15AF.5050902@hp.com>
	 <20050801181357.GA31144@suse.de>
Content-Type: text/plain
Date: Tue, 02 Aug 2005 22:49:39 +0100
Message-Id: <1123019379.7782.86.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 11:13 -0700, Greg KH wrote:
> > Good question.  I was about to submit a patch that created 
> > drivers/platform because the toplevel driver for MQ11xx is a 
> > platform_device driver.  Any thoughts on this?
> 
> drivers/platform sounds good to me.

In another thread (about the ucb1x00) we came up with the idea of
drivers/mfd (mfd = multi function devices).

The core and platform specific parts would live here with suitable clear
naming and the subsection specific parts that were separable would live
in the appropriate place within the kernel.

Just another idea to add to the mix and removes the dilemma of a
multifunction device with isn't platform based...

Richard

