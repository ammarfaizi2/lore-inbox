Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbVI1Qfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbVI1Qfl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 12:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbVI1Qfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 12:35:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7371 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751406AbVI1Qfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 12:35:39 -0400
Date: Wed, 28 Sep 2005 09:35:54 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: "Eshwar" <eshwar@moschip.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: TCP Network performance degade from 2.4.18 to 2.6.10
Message-ID: <20050928093554.418b79a2@localhost.localdomain>
In-Reply-To: <LEXUSAX3cf3ednHM3SO00000be8@lexus.moschip.com>
References: <20050726130329.GA3215@ucw.cz>
	<LEXUSAX3cf3ednHM3SO00000be8@lexus.moschip.com>
X-Mailer: Sylpheed-Claws 1.9.14 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2005 10:42:22 +0530
"Eshwar" <eshwar@moschip.com> wrote:

> HI all,
> 
> I observed there is huge network performance drop from linux 2.4 to 2.6 with
> the same setup (No hardware changes..). The results are taken in PIV
> processor with D-Link network card... with iperf ... Can some body help me
> why such a huge difference... in TCP stream... 
> 
> In linux 2.4 (Redhat 9)
> 
> DLink	
>     TCP              UDP
> Tx       94.3Mbps    Tx               95 Mbps
> Rx       94.2 Mbps   Rx               95 Mbps
> 
> In linux 2.6.10 (Fedora Core 4)
> DLink	
> 	 TCP                     UDP
> Tx       64.3 Mbps 	Tx               87 Mbps
> Rx       88.1 Mbps      Rx               95 Mbps
> 
> 
> Thanks & Regards
> Eshwar

Please send network performance discussion to netdev@vger.kernel.org

A lot more information is needed, like:
	* which hardware is on both ends of the test (lscpci)
	* any TCP configuration issues
	* any errors reported.
	* netfilter and firewalling.
