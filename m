Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbUK0Q0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUK0Q0E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 11:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbUK0Q0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 11:26:04 -0500
Received: from gprs214-10.eurotel.cz ([160.218.214.10]:34688 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261252AbUK0QYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 11:24:14 -0500
Date: Sat, 27 Nov 2004 17:23:58 +0100
From: Pavel Machek <pavel@ucw.cz>
To: hugang@soulinfo.com
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Suspend2 merge: 1/51: Device trees
Message-ID: <20041127162358.GC1012@elf.ucw.cz>
References: <20041125165413.GB476@openzaurus.ucw.cz> <20041125185304.GA1260@elf.ucw.cz> <1101421336.27250.80.camel@desktop.cunninghams> <20041127161319.GB2472@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041127161319.GB2472@hugang.soulinfo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > SUSPEND all but swap device and parents
> > WRITE LRU pages
> > SUSPEND swap device and parents (+sysdev)
> > Snapshot
> > RESUME swap device and parents (+sysdev)
> > WRITE snapshot
> > SUSPEND swap device and parents
> > POWERDOWN everything
> > 
> -device-tree.diff-

(snipped 420 lines of diff)

No, this one should not be neccessary. It is there only to solve some
memory problems, and it does not solve them anyway.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
