Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262894AbVCQAQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbVCQAQr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 19:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262889AbVCQAOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 19:14:10 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:12209 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262896AbVCQANi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 19:13:38 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: CPU hotplug on i386
Date: Thu, 17 Mar 2005 01:16:33 +0100
User-Agent: KMail/1.7.1
Cc: Nathan Lynch <ntl@pobox.com>, kernel list <linux-kernel@vger.kernel.org>,
       rusty@rustcorp.com.au
References: <20050316132151.GA2227@elf.ucw.cz> <200503170051.58579.rjw@sisk.pl> <20050317000410.GA3210@elf.ucw.cz>
In-Reply-To: <20050317000410.GA3210@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503170116.33600.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 17 of March 2005 01:04, Pavel Machek wrote:
> Hi!
> 
> > > > I tried to solve long-standing uglyness in swsusp cmp code by calling
> > > > cpu hotplug... only to find out that CONFIG_CPU_HOTPLUG is not
> > > > available on i386. Is there way to enable CPU_HOTPLUG on i386?
> > > 
> > > i386 cpu hotplug has been in -mm for a while.  Don't know when (if
> > > ever) it will get merged.
> > 
> > Thanks a lot for this hint! ;-)
> > 
> > Pavel, I've ported the basic i386 CPU hotplug stuff, without the sysfs
> > interface, to x86-64 (a cut'n'paste kind of work, mostly).  For now, I've
> > made HOTPLUG_CPU on x86-64 depend on SMP and SOFTWARE_SUSPEND and be set
> > automatically.
> > 
> > I'm going to test it together with your patch tomorrow.
> 
> Hey, don't count on my patch. It is first shot, never tested.

It'll be the first time, then.  I'm not afraid. ;-)

Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
