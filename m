Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbULMALU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbULMALU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 19:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbULMALU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 19:11:20 -0500
Received: from mailhost.somanetworks.com ([216.126.67.42]:47255 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id S262175AbULMALN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 19:11:13 -0500
Date: Sun, 12 Dec 2004 19:11:10 -0500 (EST)
From: Scott Murray <scottm@somanetworks.com>
X-X-Sender: scottm@rancor.yyz.somanetworks.com
To: Adrian Bunk <bunk@stusta.de>
cc: pcihpd-discuss@lists.sourceforge.net, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/pci/hotplug/ : simply use MODULE
In-Reply-To: <20041211165459.GV22324@stusta.de>
Message-ID: <Pine.LNX.4.58.0412121908500.23843@rancor.yyz.somanetworks.com>
References: <20041211165459.GV22324@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Dec 2004, Adrian Bunk wrote:

> The patch below lets five files under drivers/pci/hotplug/ simply use 
> MODULE to check whether they are compiled as part of a module.
> 
> MODULE is the common idiom for checking whether a file is built as part 
> of a module.
> 
> In theory, my patch shouldn't have made any difference, but if you look 
> closely, the previous #if's in cpcihp_generic.c and cpci_hotplug_pci.c 
> weren't correct.

Yep, those were never fixed after the drivers/hotplug to 
drivers/pci/hotplug move, my bad for not checking things
better after that was done.

Thanks,

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com
