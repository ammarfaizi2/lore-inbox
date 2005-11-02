Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbVKBAcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbVKBAcM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 19:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbVKBAcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 19:32:12 -0500
Received: from xenotime.net ([66.160.160.81]:17311 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751479AbVKBAcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 19:32:10 -0500
Date: Tue, 1 Nov 2005 16:32:10 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Marcel Holtmann <marcel@holtmann.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with the default IOSCHED
In-Reply-To: <1130891282.5048.50.camel@blade>
Message-ID: <Pine.LNX.4.58.0511011631360.11761@shark.he.net>
References: <1130891282.5048.50.camel@blade>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2005, Marcel Holtmann wrote:

> Hi guys,
>
> by accident I selected the anticipatory IO scheduler as default in my
> kernel config, but only the CFQ was built in. The anticipatory and
> deadline were only available as modules. This caused an oops at boot.
> After selecting CFQ as default schedule and a recompile and reboot
> everything was fine again.

What kernel version?  There are already some patches
in 2.6.14-gitN for this kind of problem.
Have you tried the -git updates?

-- 
~Randy
