Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUIDWMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUIDWMj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 18:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUIDWMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 18:12:39 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:39969 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S264299AbUIDWMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 18:12:30 -0400
Message-ID: <9e47339104090415123750a1eb@mail.gmail.com>
Date: Sat, 4 Sep 2004 18:12:29 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: multi-domain PCI and sysfs
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200409041457.46578.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e4733910409041300139dabe0@mail.gmail.com>
	 <200409041457.46578.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Sep 2004 14:57:46 -0700, Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> Yep, on all the machines I've used.
> 
> sn2 (ia64):
> [root@flatearth ~]# ls -l /sys/devices
> total 0
> drwxr-xr-x  5 root root 0 Sep  5 08:07 pci0000:01
> drwxr-xr-x  3 root root 0 Sep  5 08:07 pci0000:02
> drwxr-xr-x  2 root root 0 Sep  5 08:07 platform
> drwxr-xr-x  5 root root 0 Sep  5 08:07 system

sn2 looks wrong. It should be
> drwxr-xr-x  5 root root 0 Sep  5 08:07 pci0000:01
> drwxr-xr-x  3 root root 0 Sep  5 08:07 pci0001:02
> drwxr-xr-x  2 root root 0 Sep  5 08:07 platform
> drwxr-xr-x  5 root root 0 Sep  5 08:07 system

-- 
Jon Smirl
jonsmirl@gmail.com
