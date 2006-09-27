Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030492AbWI0Rq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030492AbWI0Rq7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 13:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030491AbWI0Rq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 13:46:58 -0400
Received: from nwd2mail11.analog.com ([137.71.25.57]:39734 "EHLO
	nwd2mail11.analog.com") by vger.kernel.org with ESMTP
	id S1030492AbWI0Rq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 13:46:57 -0400
X-IronPort-AV: i="4.09,225,1157342400"; 
   d="scan'208"; a="10386604:sNHT19044228"
Message-Id: <6.1.1.1.0.20060927132022.01ed0450@ptg1.spd.analog.com>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.1.1
Date: Wed, 27 Sep 2006 13:47:16 -0400
To: Randy Dunlap <dunlap@xenotime.net>
From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Cc: arnd Bergmann <arnd@arndb.de>, luke Yang <luke.adi@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy wrote:

>except for coding style nits.  E.g., the patch above:
>a.  uses spaces instead of tabs for indentation

yeah - my copy/paste/mailer is broken - when it copies tabs, it pastes 
space into the mailer.

>b.  has an extra (unwanted) space in:
> > +               if (likely( !need_resched()))
>                              ^

There are still lots of places where we need to fix up broken white space 
in our patches.

Does anyone have a script that identifies white space problems?

Thanks
-Robin 
