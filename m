Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbUBVRwV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 12:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbUBVRwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 12:52:21 -0500
Received: from pop.gmx.net ([213.165.64.20]:42163 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261712AbUBVRwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 12:52:18 -0500
X-Authenticated: #4512188
Message-ID: <4038EC4B.6030309@gmx.de>
Date: Sun, 22 Feb 2004 18:52:11 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Badness in pci_find_subsys
References: <200402221846.15010.robin.rosenberg.lists@dewire.com>
In-Reply-To: <200402221846.15010.robin.rosenberg.lists@dewire.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Rosenberg wrote:
> There is a regular error (2.6.1,2.6.2) that locks up my X although I don't know if it has anything to
> do with X per se other than that after every lockup i find an error in syslog.
> 
> Feb 22 18:23:25 h6n2fls33o811 kernel: Badness in pci_find_subsys at drivers/pci/search.c:167
> Feb 22 18:23:25 h6n2fls33o811 kernel: Call Trace:
> Feb 22 18:23:25 h6n2fls33o811 kernel:  [pci_find_subsys+215/224] pci_find_subsys+0xd7/0xe0
>
[snip]

It is Nvidia binary driver doing some crap.

Prakash

