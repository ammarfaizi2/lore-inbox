Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270768AbTGNT4n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 15:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270758AbTGNT4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 15:56:15 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:64963
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270782AbTGNTxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 15:53:48 -0400
Subject: Re: Alan Shih: "TCP IP Offloading Interface"
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David griego <dagriego@hotmail.com>
Cc: jgarzik@pobox.com, alan@storlinksemi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Sea2-F4kWkKEsEXlwM9000178d9@hotmail.com>
References: <Sea2-F4kWkKEsEXlwM9000178d9@hotmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058213152.561.129.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jul 2003 21:05:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-07-14 at 20:43, David griego wrote:
> Intel Clusters and Network Storage Volume Platforms Lab reported that it 
> takes about 1MHz to process 1Mbps on a PIII.  Using this rule of thumb (they 

1MHz to proces 1Mbit doing what - file I/O to and from disk, web serving
- because ToE or otherwise I still have to process the data I receive
and do something useful with it unless I'm just a router, firewall or
load balancer. If you want to argue about using gate arrays and hardware
to accelerate IP routing, balancing and firewall filter cams then you
might get somewhere - but they dont need to talk TCP.

Also if its 1MHz per 1Mbit worse case and your ToE engine isnt entirely
hardware paths capable of sustaining 10Gbit/sec, what happens when I hit
you with 10Gbit of carefully chosen non optimal frames ?

