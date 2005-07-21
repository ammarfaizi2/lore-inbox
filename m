Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbVGUKJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbVGUKJu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 06:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVGUKJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 06:09:50 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:18664 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261719AbVGUKJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 06:09:49 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Brown, Len" <len.brown@intel.com>
Subject: Re: Linux v2.6.13-rc3
Date: Thu, 21 Jul 2005 12:09:45 +0200
User-Agent: KMail/1.8.1
Cc: "Linus Torvalds" <torvalds@osdl.org>, acpi-devel@lists.sourceforge.net,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Li, Shaohua" <shaohua.li@intel.com>,
       "Yu, Luming" <luming.yu@intel.com>, "Greg KH" <greg@kroah.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B30041AC76D@hdsmsx401.amr.corp.intel.com>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30041AC76D@hdsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507211209.46039.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 21 of July 2005 07:30, Brown, Len wrote:
> >Len, ACPI people - can we fix this regression, please?
> >
> >Rafael even pinpoints exactly which patches are causing the 
> >problem, so why didn't they get reverted before sending them off to me?
> 
> Linus,
> I'm sorry it was in '-rc3' -- that is as soon as I could
> muster the bk->git transition.  Now that I'm running on git,
> I expect I'll be able to get the development/testing/push
> pipeline moving and back on schedule.
> 
> Yes, we discovered both of these regressions in mm.
> Yes, Rafael has been a sport in filing good bug reports,
> and his Asus L5D has been an interesting case.
> 
> Although we broke this system, I do believe that there is
> significant value in keeping these changes in the mainline,
> as I believe that it is the fastest path to improved support
> for all systems.  Specifically...

In short: If the changes are generally needed, I can live with them
(as long as I know what patches to revert :-)).

Still it would be nice to let people know what to do if they have problems with
these changes.  Many people don't run -rc kernels and even more people
don't run -mm, so they have no idea that there are known regressions  ...

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
