Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264495AbTEJUgS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 16:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbTEJUgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 16:36:17 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:57836 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S264495AbTEJUgR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 16:36:17 -0400
Date: Sat, 10 May 2003 22:47:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Will Dinkel <wdinkel@atipa.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86_64 interrupts handled by CPU0 only
Message-ID: <20030510204701.GB577@elf.ucw.cz>
References: <1052326953.22518.184.camel@zappa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052326953.22518.184.camel@zappa>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I see this behavior on systems using either the MSI or Tyan dual-opteron
> boards.  I also see it on RedHat's preview x86_64 distribution (kernel
> version 2.4.20-9.2).
> 
> I'm still trying to get 2.5.69 to boot correctly, so I don't have
> results there yet.  On RedHat it hangs after "Booting the kernel..."
> (and yes, I have CONFIG_VT, and CONFIG_VT_CONSOLE on).  Any ideas?

Turn *on* CONFIG_HUGETLB_PAGE or how is it called.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
