Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267179AbSLKOuS>; Wed, 11 Dec 2002 09:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267174AbSLKOuR>; Wed, 11 Dec 2002 09:50:17 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:34570 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S267179AbSLKOuQ>; Wed, 11 Dec 2002 09:50:16 -0500
Date: Wed, 11 Dec 2002 14:58:00 +0000
To: lvm-devel@sistina.com
Cc: Kevin Corry <corryk@us.ibm.com>,
       Joe Thornber <joe@fib011235813.fsnet.co.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [lvm-devel] Re: [PATCH] dm.c - device-mapper I/O path fixes
Message-ID: <20021211145800.GB21986@reti>
References: <02121016034706.02220@boiler> <200212111330.gBBDTTa06416@Port.imtp.ilyichevsk.odessa.ua> <02121107165303.29515@boiler> <200212111430.gBBETua06759@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212111430.gBBETua06759@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 05:19:33PM -0200, Denis Vlasenko wrote:
> > Are you saying the "if (error)" part is pointless? If so, I have to
> 
> No. Locking is pointless. What exactly you try to protect here? 

io->error from being updated concurrently.
