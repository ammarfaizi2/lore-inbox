Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWEVRyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWEVRyE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 13:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWEVRyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 13:54:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32933 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751098AbWEVRyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 13:54:01 -0400
Date: Mon, 22 May 2006 19:53:16 +0200
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@redhat.com>, Laurence Vanek <lvanek@charter.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
       Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>,
       Greg Kroah-Hartman <gregkh@suse.de>, Jean Delvare <khali@linux-fr.org>
Subject: Re: Kernel 2.6.16-1.2122_FC5 & lmsensors
Message-ID: <20060522175316.GC2979@elf.ucw.cz>
References: <4471F028.4090803@charter.net> <20060522174818.GA8016@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060522174818.GA8016@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 22-05-06 13:48:18, Dave Jones wrote:
> On Mon, May 22, 2006 at 12:08:56PM -0500, Laurence Vanek wrote:
>  > Upon updating to the latest kernel (2.6.16-1.2122_FC5) & rebooting I 
>  > find that I no longer have lmsensors.  /var/log/messages gives this in 
>  > the suspect area:
>  > 
>  > ==========
>  > May 22 11:42:42 localhost kernel: i2c_adapter i2c-0: SMBus Quick command 
>  > not supported, can't probe for chips
>  > May 22 11:42:42 localhost kernel: i2c_adapter i2c-1: SMBus Quick command 
>  > not supported, can't probe for chips
>  > May 22 11:42:42 localhost kernel: i2c_adapter i2c-2: SMBus Quick command 
>  > not supported, can't probe for chips
>  > =========
>  > 
>  > something new in this release?
> 
> Probably a side-effect of [PATCH] smbus unhiding kills thermal management
> merged in 2.6.16.17.  Is this an ASUS board ?

You can disable CONFIG_ACPI_SLEEP, if it gets you lmsensors back, that
is it.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
