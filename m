Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264471AbUAAQSH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 11:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264453AbUAAQSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 11:18:07 -0500
Received: from mail2-116.ewetel.de ([212.6.122.116]:55180 "EHLO
	mail2.ewetel.de") by vger.kernel.org with ESMTP id S264471AbUAAQRz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 11:17:55 -0500
Date: Thu, 1 Jan 2004 17:17:50 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
In-Reply-To: <20031231192306.GG25389@kroah.com>
Message-ID: <Pine.LNX.4.44.0401011714460.934-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Dec 2003, Greg KH wrote:

> You would not have any "extra" overhead if you don't add any new devices
> to your system.  udev only runs when /sbin/hotplug runs. As for extra
> space on your disk, this email thread is almost as big as the udev
> binary is :)

Well, but if random device numbers become a reality, udev would have
to run at boot time or I wouldn't get usable device nodes. So there
is some setup complexity (because so far I don't need a correctly setup
hotplug system at all). Not much of a problem, granted, distributions
will do this for most of us and only a few people will do it by hand.

-- 
Ciao,
Pascal

