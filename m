Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965130AbVKBQ0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbVKBQ0s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 11:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965131AbVKBQ0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 11:26:48 -0500
Received: from xenotime.net ([66.160.160.81]:42451 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965130AbVKBQ0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 11:26:47 -0500
Date: Wed, 2 Nov 2005 08:26:43 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Daniel J Blueman <daniel.blueman@gmail.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: cpuset - question
In-Reply-To: <6278d2220511020236l26f74eecp11910e59fd1c432d@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0511020825450.6456@shark.he.net>
References: <6278d2220511020236l26f74eecp11910e59fd1c432d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2005, Daniel J Blueman wrote:

> Janos,
>
> You can see what valid memory nodes are available from the top-level
> cpuset directory:
>
> # cat /dev/cpuset/mems
> 0 1 2 3
>
> If you were to be running on a NUMA-capable system, you'd also want to
> ensure page interleaving was disabled in the BIOS/pre-boot firmware
> too.
> ___

Just for info, why is this in /dev at all, instead of, say,
/sys ??

-- 
~Randy
