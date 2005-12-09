Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbVLIVT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbVLIVT3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 16:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbVLIVT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 16:19:28 -0500
Received: from fattire.cabal.ca ([134.117.69.58]:44462 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S932454AbVLIVT2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 16:19:28 -0500
Date: Fri, 9 Dec 2005 16:19:16 -0500
From: Kyle McMartin <kyle@mcmartin.ca>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: i386 -> x86_64 cross compile failure (binutils bug?)
Message-ID: <20051209211916.GI32168@quicksilver.road.mcmartin.ca>
References: <1134154208.14363.8.camel@mindpipe> <20051209195816.GF32168@quicksilver.road.mcmartin.ca> <1134159677.18432.7.camel@mindpipe> <20051209204151.GH32168@quicksilver.road.mcmartin.ca> <1134162614.18432.19.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134162614.18432.19.camel@mindpipe>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem does not seem to be lack of x86-64 support in the assembler.
> I symlinked /usr/bin/as to /usr/x86_64/bin/x86_64-linux-as and got the
> exact same relocation error.
>

The problem appears to be that your GCC doesn't have support for these
relocations, not AS.
 
