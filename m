Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbULHWIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbULHWIk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 17:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbULHWGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 17:06:51 -0500
Received: from quickstop.soohrt.org ([81.2.155.147]:56017 "EHLO
	quickstop.soohrt.org") by vger.kernel.org with ESMTP
	id S261384AbULHWGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 17:06:06 -0500
Date: Wed, 8 Dec 2004 23:06:01 +0100
From: Karsten Desler <kdesler@soohrt.org>
To: Robert Olsson <Robert.Olsson@data.slu.se>
Cc: Karsten Desler <kdesler@soohrt.org>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       jamal <hadi@cyberus.ca>, P@draigBrady.com
Subject: Re: _High_ CPU usage while routing (mostly) small UDP packets
Message-ID: <20041208220601.GA18066@quickstop.soohrt.org>
References: <20041206205305.GA11970@soohrt.org> <20041207211035.GA20286@quickstop.soohrt.org> <16822.12630.275389.575326@robur.slu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16822.12630.275389.575326@robur.slu.se>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Olsson <Robert.Olsson@data.slu.se> wrote:
>    rhash_entries=  [KNL,NET]
>                         Set number of hash buckets for route cache

IP: routing cache hash table of 131072 buckets, 1024Kbytes
A 3 percent improvement over the average cpu usage in the last 8 hours
compared to the same time yesterday.
Still in the noise.

I'm going to try a day without netfilter next and then the realloc_skb
patch.

Cheers,
 Karsten
