Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263323AbUCTKX2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 05:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263321AbUCTKWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 05:22:25 -0500
Received: from mail.gmx.de ([213.165.64.20]:24458 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263323AbUCTKVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 05:21:11 -0500
X-Authenticated: #4512188
Message-ID: <405C1B14.6000206@gmx.de>
Date: Sat, 20 Mar 2004 11:21:08 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.5-rc2, hotplug and ohci-hcd issue
References: <Pine.LNX.4.58.0403191937160.1106@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0403191937160.1106@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

it already started with 2.6.5-rc1: On shutdown/reboot when hotplug 
service stops, it hangs. I found out that hotplug has trouble in 
removing ohci-hcd module, ie, it doesn't seem to work. killall -9 rmmod 
doesn't remove that process, neither. (Module unloading is in the kernel).

Which infos are needed furthermore?

Cheers,

Prakash
