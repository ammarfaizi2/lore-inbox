Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267165AbSLKPES>; Wed, 11 Dec 2002 10:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267174AbSLKPES>; Wed, 11 Dec 2002 10:04:18 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:56592 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S267165AbSLKPES>; Wed, 11 Dec 2002 10:04:18 -0500
Date: Wed, 11 Dec 2002 15:12:05 +0000
To: lvm-devel@sistina.com
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Joe Thornber <joe@fib011235813.fsnet.co.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [lvm-devel] Re: [PATCH] dm.c - device-mapper I/O path fixes
Message-ID: <20021211151205.GB22145@reti>
References: <02121016034706.02220@boiler> <02121107165303.29515@boiler> <200212111430.gBBETua06759@Port.imtp.ilyichevsk.odessa.ua> <02121108022404.29515@boiler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02121108022404.29515@boiler>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 08:02:24AM -0600, Kevin Corry wrote:
> Perhaps we could make "error" and atomic_t, and store the absolute-value of 
> the error code, and always return -error in the bio_endio() call. Or is that 
> just too ugly?

Too ugly :)
