Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbTBSVM3>; Wed, 19 Feb 2003 16:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261599AbTBSVM2>; Wed, 19 Feb 2003 16:12:28 -0500
Received: from rth.ninka.net ([216.101.162.244]:6049 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S261594AbTBSVM1>;
	Wed, 19 Feb 2003 16:12:27 -0500
Subject: Re: [PATCH] add new DMA_ADDR_T_SIZE define
From: "David S. Miller" <davem@redhat.com>
To: Ion Badulescu <ionut@badula.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0302191225510.29393-100000@guppy.limebrokerage.com>
References: <Pine.LNX.4.44.0302191225510.29393-100000@guppy.limebrokerage.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Feb 2003 14:06:47 -0800
Message-Id: <1045692407.14307.11.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-19 at 09:28, Ion Badulescu wrote:
> then you're probably debugging, not performance-tuning, so the cast to u64 
> is acceptable.

Not true, you must cast to 'long long' as there is no appropriate
printf format string for u64 that works warning-free on all
systems.

