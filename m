Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161740AbWKHW5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161740AbWKHW5N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161709AbWKHW5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:57:13 -0500
Received: from mga06.intel.com ([134.134.136.21]:49336 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1423859AbWKHW5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:57:10 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,401,1157353200"; 
   d="scan'208"; a="158461727:sNHT13400401308"
Subject: Re: 2.6.19-rc1: Volanomark slowdown
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: Olaf Kirch <okir@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       davem@sunset.davemloft.net, kuznet@ms2.inr.ac.ru,
       netdev@vger.kernel.org
In-Reply-To: <20061108221028.GA16889@suse.de>
References: <1162924354.10806.172.camel@localhost.localdomain>
	 <1163001318.3138.346.camel@laptopd505.fenrus.org>
	 <20061108162955.GA4364@suse.de>
	 <1163011132.10806.189.camel@localhost.localdomain>
	 <20061108221028.GA16889@suse.de>
Content-Type: text/plain
Organization: Intel
Date: Wed, 08 Nov 2006 14:07:32 -0800
Message-Id: <1163023652.10806.203.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-08 at 23:10 +0100, Olaf Kirch wrote:

> 
> In fixing performance issues, the most obvious explanation isn't always
> the right one. It's quite possible you're right, sure.
> 
> What I'm saying though is that it doesn't rhyme with what I've seen of
> Volanomark - we ran 2.6.16 on a 4p Intel box for instance and it didn't
> come close to saturating a Gigabit pipe before it maxed out on CPU load.
> 

I am running Volanomark in a loopback mode on a 2P woodcrest box 
(4 cores).  So the configuration is a bit different.  

In my testing, the CPU utilization is at 100%.  So
increase in ACKs will cost CPU to devote more
time to process those ACKs and reduce throughput.

> 
> You could count the number of outbound packets dropped on the server.
> 

As I'm running in loopback mode, there are no dropped packets.

Thanks.

Tim

