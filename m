Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267491AbUG2WcC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267491AbUG2WcC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 18:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267501AbUG2WcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 18:32:02 -0400
Received: from mail5.tpgi.com.au ([203.12.160.101]:42691 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S267491AbUG2W3W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 18:29:22 -0400
Subject: Re: fixing usb suspend/resuming
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: David Brownell <david-b@pacbell.net>,
       Alexander Gran <alex@zodiac.dnsalias.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040729210256.GC18623@elf.ucw.cz>
References: <200405281406.10447@zodiac.zodiac.dnsalias.org>
	 <40F962B6.3000501@pacbell.net>
	 <200407190927.38734@zodiac.zodiac.dnsalias.org>
	 <200407202205.37763.david-b@pacbell.net>
	 <20040729083543.GG21889@openzaurus.ucw.cz>
	 <1091103438.2703.13.camel@desktop.cunninghams>
	 <20040729210256.GC18623@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1091140000.2703.27.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 30 Jul 2004 08:26:41 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-07-30 at 07:02, Pavel Machek wrote:
> Well, its more complicated, I believe. You can't just leave those
> devices running, because they could DMA and damage the image... So you

I'm assuming (and believe I have achieved) that the only process doing
anything significant is suspend, in which case the image isn't going to
get damaged.

> need something like
> 
> suspend_fast_ill_resume_you_soon().

Don't understand what you're saying here, sorry.

Nigel


