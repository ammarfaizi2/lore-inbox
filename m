Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262764AbTDXLZW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 07:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263349AbTDXLZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 07:25:22 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:38162 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262764AbTDXLZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 07:25:20 -0400
Date: Thu, 24 Apr 2003 12:37:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc1 - unresolved
Message-ID: <20030424123720.A28562@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Eyal Lebedinsky <eyal@eyal.emu.id.au>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva> <200304220915.56757.m.c.p@wolk-project.de> <Pine.LNX.4.53L.0304231650300.7085@freak.distro.conectiva> <200304241320.52469.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200304241320.52469.m.c.p@wolk-project.de>; from m.c.p@wolk-project.de on Thu, Apr 24, 2003 at 01:27:39PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 01:27:39PM +0200, Marc-Christian Petersen wrote:
> On Wednesday 23 April 2003 21:51, Marcelo Tosatti wrote:
> 
> Hi Marcelo,
> 
> > I'm sorry for not having looked into it, Marc. My inbox is not a very
> > easily manageable thing.
> > > Search the archives. I won't post it again and again and again and again
> > > ^again^10.
> > I will look into the archives. Thank you.
> Don't waste your time with searching archives ;) Take the attached ones.
> 
> Explaination:
> 
> 01. export 'proc_get_inode' symbol b/c it's unresolved in
>     drivers/net/wan/comx.o
> 
> 	Patch by: Andrea Arcangeli

proc_get_inode is not exported by intention, and never was on 2.4.
Irt looks like no one actually uses the driver otherwise it would
have been fixed..

