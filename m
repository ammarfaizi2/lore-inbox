Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWHBHSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWHBHSi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 03:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWHBHSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 03:18:37 -0400
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:16652 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751307AbWHBHSg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 03:18:36 -0400
Date: Wed, 2 Aug 2006 09:18:41 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Shem Multinymous <multinymous@gmail.com>, Vojtech Pavlik <vojtech@suse.cz>,
       "Brown, Len" <len.brown@intel.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org,
       Henrique de Moraes Holschuh <hmh@debian.org>,
       Mark Underwood <basicmark@yahoo.com>, Greg KH <greg@kroah.com>
Subject: Re: Generic battery interface
Message-Id: <20060802091841.8585a72a.khali@linux-fr.org>
In-Reply-To: <20060731230145.GF3612@elf.ucw.cz>
References: <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com>
	<20060727232427.GA4907@suse.cz>
	<41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
	<20060728074202.GA4757@suse.cz>
	<41840b750607280814x50db03erb30d833802ae983e@mail.gmail.com>
	<20060728202359.GB5313@suse.cz>
	<41840b750607281548h5ee2219eka1de6745b692c092@mail.gmail.com>
	<41840b750607291406p2f843054rc89fa1c3c467688d@mail.gmail.com>
	<41840b750607301137t1e10fe88o3a1c73e7a4b4bf44@mail.gmail.com>
	<20060731233536.92b39035.khali@linux-fr.org>
	<20060731230145.GF3612@elf.ucw.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

> > frequently it can read from the chip. And no hardware monitoring chip I
> > know of can tell when the monitored value has changed - you have to read
> > the chip registers to know.
> 
> ACPI battery can tell when values change in significant way. (Like
> battery becoming critical).

Ah, good to know. But is there a practical use for this? I'd suspect
that the user wants to know the battery charge% all the time anyway,
critical or not.

-- 
Jean Delvare
