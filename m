Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbTJKLxR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 07:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263282AbTJKLxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 07:53:17 -0400
Received: from gprs147-20.eurotel.cz ([160.218.147.20]:48512 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263281AbTJKLxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 07:53:16 -0400
Date: Sat, 11 Oct 2003 13:53:04 +0200
From: Pavel Machek <pavel@suse.cz>
To: Narayan Desai <desai@mcs.anl.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pmdisk performance problem
Message-ID: <20031011115304.GB516@elf.ucw.cz>
References: <87k77ejkfp.fsf@mcs.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k77ejkfp.fsf@mcs.anl.gov>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> When using 2.6.0-test7 on an ibm thinkpad t21, pmdisk works properly,
> though it takes quite a while to write out pages to disk. On my last
> suspend to disk, it took on the order of 8-10 minutes. After this
> completed, i was able to successfully resume, fairly speedily, however
> my hardware clock was 8-10 minutes behind. Does anyone have any ideas
> why this is happening? thanks...

I have seen this too, with swsusp on x86-64 machine. Suspend took
awfully long, in "writing data" phase.

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
