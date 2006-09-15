Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWIOTN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWIOTN7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 15:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWIOTN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 15:13:58 -0400
Received: from iriserv.iradimed.com ([69.44.168.233]:10966 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751376AbWIOTN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 15:13:58 -0400
Message-ID: <450AFB8A.3070307@cfl.rr.com>
Date: Fri, 15 Sep 2006 15:14:18 -0400
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: xixi lii <xixi.limeng@gmail.com>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Sven-Haegar Koch <haegar@sdinet.de>,
       Linux-Kernel-Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: UDP question.
References: <a885b78b0609140900x385c9453n9ef25a936524dff7@mail.gmail.com>  <Pine.LNX.4.64.0609150129150.21941@mercury.sdinet.de>  <Pine.LNX.4.61.0609150833170.19096@yvahk01.tjqt.qr> <a885b78b0609150007u239cf363l40dd122165f7b516@mail.gmail.com>
In-Reply-To: <a885b78b0609150007u239cf363l40dd122165f7b516@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Sep 2006 19:14:07.0012 (UTC) FILETIME=[1D827E40:01C6D8FB]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14694.000
X-TM-AS-Result: No--17.866900-5.000000-4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is a question of where you are sending the packets TO, not from.  It 
is the destination address that is used to route the packet, not the 
source.  If you were sending the packets to the same destination 
address, then they will go out the same interface since the routing 
table identifies that interface as the way to reach the destination 
address.

xixi lii wrote:
> My two adapters has two different IP address, and I bind one IP on one 
> socket,
> do you mean that I alloc two socket and bind different IP is not
> helpful? In fact, all the packet sent from two socket is go out by one
> network adapter?
> 
> xixi

