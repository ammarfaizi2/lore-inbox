Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbUBWFjL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 00:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbUBWFjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 00:39:10 -0500
Received: from [212.28.208.94] ([212.28.208.94]:44810 "HELO dewire.com")
	by vger.kernel.org with SMTP id S261814AbUBWFjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 00:39:08 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: vishwas.manral@lycos.com
Subject: Re: Badness in pci_find_subsys
Date: Mon, 23 Feb 2004 06:39:00 +0100
User-Agent: KMail/1.6.1
Cc: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
References: <DMOCIEPNKDKOLIAA@mailcity.com>
In-Reply-To: <DMOCIEPNKDKOLIAA@mailcity.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402230639.00737.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 February 2004 05.44, vishwas manral wrote:
> Hi Robin/Prakash,
> 
> I was checking the pci documentation and it said under the heading Obsolete function
> pci_find_subsys() - Superseded by pci_get_subsys() as the former is not Hot plug safe.
> Could this be related to the problem

You WHAT? Read the documentation! :-) I thought the ones calling the function should do that.

I dunno, I'm not hotplugging anything and it crashes anyway, The functionality is there since
I want to hotplug a camera sometimes. but I'm not always "doing it" during uptimes that have
the crash. Anyway I assume the crux here is PCI hotplug that my machine does not do; you
need special support on the motherboard for that, right?

I found some options to try out, but no conclusive info, at the nvidia linux discussion forum.

-- robin
