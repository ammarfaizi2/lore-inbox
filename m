Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbVLBSCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbVLBSCo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 13:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbVLBSCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 13:02:44 -0500
Received: from hqemgate03.nvidia.com ([216.228.112.143]:43563 "EHLO
	HQEMGATE03.nvidia.com") by vger.kernel.org with ESMTP
	id S1750851AbVLBSCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 13:02:43 -0500
Date: Fri, 2 Dec 2005 12:02:36 -0600
From: Terence Ripperda <tripperda@nvidia.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Terence Ripperda <tripperda@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc4
Message-ID: <20051202180236.GA19327@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
References: <Pine.LNX.4.64.0511302234020.3099@g5.osdl.org> <20051201121826.GF19694@charite.de> <20051201211119.GA11437@hygelac> <Pine.LNX.4.64.0512011455090.3099@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512011455090.3099@g5.osdl.org>
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.6.13 
User-Agent: Mutt/1.5.6+20040907i
X-OriginalArrivalTime: 02 Dec 2005 18:02:20.0458 (UTC) FILETIME=[8A0C40A0:01C5F76A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 03:11:27PM -0800, torvalds@osdl.org wrote:
> There's some explanation on what is going on in mm/memory.c: see the 
> comments above the "vm_normal_page()" function (which you should never 
> use: it's for internal VM usage, but it explains how the page range 
> remapping works), and above "vm_insert_page()" (which you _should_ use).

Thanks Linus,

I didn't realize that the interface had changed. we're certainly happy
to update our driver to use the appropriate interface.

the only problem is that it appears that vm_insert_page is exported
GPL-only, which obviously creates problems.

Thanks,
Terence

