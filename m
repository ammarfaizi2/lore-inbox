Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWG3Lrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWG3Lrq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 07:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWG3Lrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 07:47:46 -0400
Received: from styx.suse.cz ([82.119.242.94]:48612 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932288AbWG3Lro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 07:47:44 -0400
Date: Sun, 30 Jul 2006 13:47:41 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Greg KH <greg@kroah.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
Subject: Re: Generic battery interface
Message-ID: <20060730114741.GC4898@suse.cz>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com> <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com> <20060727232427.GA4907@suse.cz> <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com> <20060728074202.GA4757@suse.cz> <d120d5000607280525x447e6821t734a735197481c18@mail.gmail.com> <41840b750607280819t71f55ea7off89aa917421cc33@mail.gmail.com> <d120d5000607280910t458fb6e0hdb81367b888a46db@mail.gmail.com> <20060730085500.GB17759@kroah.com> <41840b750607300252w445974b1udedf1a67114d1580@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750607300252w445974b1udedf1a67114d1580@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 12:52:52PM +0300, Shem Multinymous wrote:

> Coming to think of it, to solve the dev->sys direction, maybe we
> should have symlinks like the following?
> /sys/dev/8/0 -> /sys/block/sda
> /sys/dev/11/0 -> /sys/block/sr0
> /sys/dev/116/24 -> /sys/class/sound/pcmC0D0c

Since you can have more nodes in /dev with the same node numbers, and
this actually is useful (for granting more users/groups access to the
devices in question), this is not going to fly.

-- 
Vojtech Pavlik
Director SuSE Labs
