Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbTIOQz3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 12:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbTIOQz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 12:55:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:29591 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261556AbTIOQz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 12:55:28 -0400
Date: Mon, 15 Sep 2003 09:52:34 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Nicolae Mihalache <mache@abcpages.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.6-test4 problems: suspend and touchpad
In-Reply-To: <3F638E18.9080406@abcpages.com>
Message-ID: <Pine.LNX.4.33.0309150949270.950-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The resume works however the network adapter (Broadcom 4400) does not 
> even when restarting the network.
> ifconfig eth0 shows very big counters:
> eth0      Link encap:Ethernet  HWaddr 00:C0:9F:26:C7:15
>           UP BROADCAST NOTRAILERS RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:819 errors:4294966560 dropped:0 overruns:0 
> frame:4294966836
>           TX packets:865 errors:4294966836 dropped:0 overruns:0 
> carrier:4294967118
>           collisions:4294967204 txqueuelen:100
>           RX bytes:956732 (934.3 Kb)  TX bytes:89228 (87.1 Kb)
>           Interrupt:5
> 
> 
> Any ideas? Maybe the driver for this network card does not (correctly) 
> implement suspend/resume ?

It does not. Could you please try removing the module before you suspend? 

Thanks,


	Pat

