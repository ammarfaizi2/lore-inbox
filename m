Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270830AbTGNURt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270828AbTGNUQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:16:37 -0400
Received: from sea2-f46.sea2.hotmail.com ([207.68.165.46]:36872 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S270823AbTGNUOw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 16:14:52 -0400
X-Originating-IP: [143.182.124.3]
X-Originating-Email: [dagriego@hotmail.com]
From: "David griego" <dagriego@hotmail.com>
To: alan@lxorguk.ukuu.org.uk
Cc: jgarzik@pobox.com, alan@storlinksemi.com, linux-kernel@vger.kernel.org
Subject: Re: Alan Shih: "TCP IP Offloading Interface"
Date: Mon, 14 Jul 2003 13:29:38 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F46VJpjc0D543T00017f85@hotmail.com>
X-OriginalArrivalTime: 14 Jul 2003 20:29:38.0750 (UTC) FILETIME=[A5DE95E0:01C34A46]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>To: David griego <dagriego@hotmail.com>
>CC: jgarzik@pobox.com, alan@storlinksemi.com,   Linux Kernel Mailing List 
><linux-kernel@vger.kernel.org>
>Subject: Re: Alan Shih: "TCP IP Offloading Interface"
>Date: 14 Jul 2003 21:05:53 +0100
>
>On Llu, 2003-07-14 at 20:43, David griego wrote:
> > Intel Clusters and Network Storage Volume Platforms Lab reported that it
> > takes about 1MHz to process 1Mbps on a PIII.  Using this rule of thumb 
>(they
>
>1MHz to proces 1Mbit doing what - file I/O to and from disk, web serving
>- because ToE or otherwise I still have to process the data I receive
>and do something useful with it unless I'm just a router, firewall or
>load balancer. If you want to argue about using gate arrays and hardware
>to accelerate IP routing, balancing and firewall filter cams then you
>might get somewhere - but they dont need to talk TCP.
This was stream testing nTTCP, so no other IO work being done.  Freedom from 
TCP processing would allow for other tasks such as RAID and storage 
virtualization.
>
>Also if its 1MHz per 1Mbit worse case and your ToE engine isnt entirely
>hardware paths capable of sustaining 10Gbit/sec, what happens when I hit
>you with 10Gbit of carefully chosen non optimal frames ?
I'll let the hardware teams figure that out.  From my understanding it going 
to be done.

_________________________________________________________________
MSN 8 with e-mail virus protection service: 2 months FREE*  
http://join.msn.com/?page=features/virus

