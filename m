Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWGKUW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWGKUW0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 16:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWGKUW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 16:22:26 -0400
Received: from mail.suse.de ([195.135.220.2]:32697 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751137AbWGKUWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 16:22:25 -0400
Date: Tue, 11 Jul 2006 22:22:23 +0200
From: Olaf Hering <olh@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jeff Garzik <jeff@garzik.org>, Michael Tokarev <mjt@tls.msk.ru>,
       Roman Zippel <zippel@linux-m68k.org>, torvalds@osdl.org,
       klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
Message-ID: <20060711202223.GA17928@suse.de>
References: <44B37D9D.8000505@tls.msk.ru> <20060711112746.GA14059@suse.de> <44B3D0A0.7030409@zytor.com> <20060711164040.GA16327@suse.de> <44B3DA77.50103@garzik.org> <20060711171624.GA16554@suse.de> <44B3E7D5.8070100@zytor.com> <20060711181552.GD16869@suse.de> <44B3EC5A.1010100@zytor.com> <20060711200640.GA17653@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060711200640.GA17653@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Jul 11, Olaf Hering wrote:

> My point is:

Of course thats not the only one.
If nothing changes in userspace, it still has to be build with every new
kernel no matter how many other kernel changes were just added.
I remember it took some time to build klibc-0.123.
And if klibc really depends on kernel headers, and I do git-bisect on a
slower box, thats a waste of time. That really asks for an external
binary. Or CONFIG_KLIBC=n, if thats not convincing.
