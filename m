Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVCCMlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVCCMlG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 07:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVCCMk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 07:40:59 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:30932 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261685AbVCCMdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 07:33:08 -0500
Subject: Re: [PATCH]: Speed freeing memory for suspend.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Andrew Morton <akpm@osdl.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20050303032620.69add028.akpm@osdl.org>
References: <1109848654.3733.34.camel@desktop.cunningham.myip.net.au>
	 <20050303032620.69add028.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1109853301.3733.36.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 03 Mar 2005 23:35:01 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2005-03-03 at 22:26, Andrew Morton wrote:
> Nigel Cunningham <ncunningham@cyclades.com> wrote:
> >
> > Here's a patch I've prepared which improves the speed at which memory is
> >  freed prior to suspend. It should be a big gain for swsusp.
> 
> Patch is simple enough but, as always, please back up an optimization patch
> with quantitative test results.

Okay.

I'll see if I can do some timings in the morning.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://softwaresuspend.berlios.de


