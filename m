Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbVKFUg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbVKFUg5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 15:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbVKFUg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 15:36:57 -0500
Received: from sccrmhc12.comcast.net ([63.240.77.82]:17571 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751221AbVKFUg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 15:36:57 -0500
In-Reply-To: <Pine.LNX.4.64.0511061332250.3646@localhost.localdomain>
References: <Pine.LNX.4.64.0511061332250.3646@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <948C3295-8F5A-44A2-BD51-E970FE9D603E@comcast.net>
Cc: panto@intracom.gr, akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: [PATCH] FEC_8xx dependency on CONFIG_PPC
Date: Sun, 6 Nov 2005 15:36:52 -0500
To: Parag Warudkar <kernel-stuff@comcast.net>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 6, 2005, at 1:41 PM, Parag Warudkar wrote:

> Just noticed that make allmodconfig breaks on i386 due to the  
> FEC_8xx driver.
>
> I don't know much about FEC_8xx but I have a feeling that's because  
> it is intended only for PPC boxes.
>
> A simple change to drivers/net/fec_8xx/Kconfig to make it dependent  
> on PPC in addition to NET_ETHERNET allows make allmodconfig to build.
>
> Please suggest if the attached patch is Ok.
>
> Parag
> <patch-fec_8xx-Kconfig>

Dunno how Pine put that wrong sender email in, sending from normal  
place this time to correct it - sorry about that.

Parag
