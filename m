Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbWGYX1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbWGYX1v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 19:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbWGYX1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 19:27:50 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:995 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1030254AbWGYX1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 19:27:50 -0400
In-Reply-To: <17606.31023.273943.551848@cargo.ozlabs.ibm.com>
References: <20060725174100.GA4608@hmsreliant.homelinux.net> <03BCDC7F-13D9-42FC-86FC-30C76FD3B3B8@kernel.crashing.org> <20060725182833.GE4608@hmsreliant.homelinux.net> <44C66C91.8090700@zytor.com> <17606.31023.273943.551848@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5F730DDA-7A1C-4514-873F-9EB37CB7719E@kernel.crashing.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Neil Horman <nhorman@tuxdriver.com>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
Date: Wed, 26 Jul 2006 01:27:46 +0200
To: Paul Mackerras <paulus@samba.org>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's not that bad; if userspace is running, the cpu isn't idle, so
> there isn't the motivation to go tickless on that cpu.  In other
> words, if every cpu has suspended ticks, then no cpu can be running
> stuff that needs to look at this page.

If I read the patch correctly, none of those legacy RTC ticks
can ever be suspended though?


Segher

