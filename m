Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269745AbUJAKVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269745AbUJAKVv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 06:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269744AbUJAKVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 06:21:51 -0400
Received: from gprs214-29.eurotel.cz ([160.218.214.29]:36224 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S269745AbUJAKVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 06:21:47 -0400
Date: Fri, 1 Oct 2004 12:21:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Kevin Fenzi <kevin-linux-kernel@scrye.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3 software suspend (pmdisk) stopped working
Message-ID: <20041001102135.GB18786@elf.ucw.cz>
References: <415C2633.3050802@0Bits.COM> <20040930155644.BFF1CD6F5D@voldemort.scrye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040930155644.BFF1CD6F5D@voldemort.scrye.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Mitch> Hi, Anyone noticed that pmdisk software suspend stopped working
> Mitch> in -rc3 ?  In -rc2 it worked just fine. My script was
> 
> Mitch>   chvt 1 echo -n shutdown >/sys/power/disk echo -n disk
> Mitch> >/sys/power/state chvt 7
> 
> Mitch> In -rc3 it appears to write pages out to disk, but never shuts
> Mitch> down the machine. Is there something else i need to do or am
> Mitch> missing ?
> 
> What do you get from:
> 
> cat /sys/power/disk
> ?
> 
> If it says "platform" you might try: 
> 
> echo "shutdown" > /sys/power/disk
> 
> I wonder how many of Pavel's speed improvment patches went in with the
> pmdisk/swsusp merge in rc3? I guess I can try it and see. :) 

The most important speed fix is not there, I wanted it to do take more
testing...

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
