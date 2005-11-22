Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbVKVWvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbVKVWvf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 17:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbVKVWvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 17:51:35 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40833 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030214AbVKVWvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 17:51:35 -0500
Date: Tue, 22 Nov 2005 23:51:20 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor_core@ameritech.net>,
       Bj?rn Mork <bjorn@mork.no>
Subject: Re: Resume from swsusp stopped working with 2.6.14 and 2.6.15-rc1
Message-ID: <20051122225120.GI1748@elf.ucw.cz>
References: <87zmoa0yv5.fsf@obelix.mork.no> <200511220026.55589.dtor_core@ameritech.net> <20051122184739.GB1748@elf.ucw.cz> <200511222315.31033.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511222315.31033.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, I do not think this problem will surface again. It is first
> > failure in pretty long time. If it happens again, I'll take your
> > patch.
> 
> If so, could you please make it printk() a message after the timeout has
> passed?  This way the user will know what's going on at least.

We do have messages there, they even tell you name of process that was
not stopped. That's enough to debug failure quickly.
								Pavel
-- 
Thanks, Sharp!
