Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269750AbUJAKZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269750AbUJAKZK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 06:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269749AbUJAKZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 06:25:09 -0400
Received: from gprs214-29.eurotel.cz ([160.218.214.29]:36736 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S269743AbUJAKYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 06:24:07 -0400
Date: Fri, 1 Oct 2004 12:23:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Mitch <Mitch@0Bits.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3 software suspend (pmdisk) stopped working
Message-ID: <20041001102351.GC18786@elf.ucw.cz>
References: <415C2633.3050802@0Bits.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415C2633.3050802@0Bits.COM>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Anyone noticed that pmdisk software suspend stopped working in -rc3 ?
> In -rc2 it worked just fine. My script was
> 
>  chvt 1
>  echo -n shutdown >/sys/power/disk
>  echo -n disk >/sys/power/state
>  chvt 7
> 
> In -rc3 it appears to write pages out to disk, but never shuts down the
> machine. Is there something else i need to do or am missing ?

You are not missing anything, it is somehow broken. I'll try to find
out what went wrong and fix it. In the meantime, look at -mm series,
it works there.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
