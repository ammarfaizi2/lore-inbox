Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbTE2IXZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 04:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbTE2IXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 04:23:24 -0400
Received: from 19.Red-213-97-251.pooles.rima-tde.net ([213.97.251.19]:21950
	"EHLO linalco.com") by vger.kernel.org with ESMTP id S261998AbTE2IXY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 04:23:24 -0400
Date: Thu, 29 May 2003 10:34:54 +0200
From: Ragnar Hojland Espinosa <ragnar@linalco.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       manish <manish@storadinc.com>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030529083454.GA6098@linalco.com>
References: <3ED2DE86.2070406@storadinc.com> <3ED3A2AB.3030907@gmx.net> <3ED3A55E.8080807@storadinc.com> <200305271954.11635.m.c.p@wolk-project.de> <20030528093654.GA20687@linalco.com> <1054119522.20167.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054119522.20167.4.camel@dhcp22.swansea.linux.org.uk>
X-Edited-With-Muttmode: muttmail.sl - 2001-09-27
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28, 2003 at 11:58:43AM +0100, Alan Cox wrote:
> On Mer, 2003-05-28 at 10:36, Ragnar Hojland Espinosa wrote:
> > Actually it just happens in the fixing stage when burning prebuilt iso
> > images from the hard disk (same IDE channel as the burner, 2.4.20)
> > Having a completely frozen machine under X was quite panic inducing ;)
> 
> If you have a disk and the burner ont he same channel this is quite
> normal. The fixate is a single ATAPI command and like all ATA commands
> locks the bus to both master/slave for its duration of execution.
> 
> Its an IDE limitation

Thats what you get for cheap hardware ;)  Anyway, I do have two
questions regarding pauses when fixating, in case someone knows..

- Why it doesn't the freeze always happen (I think it doesn't)
- Why doesn't the complete computer freeze happen always.

-- 
Ragnar Hojland - Project Manager
Linalco "Especialistas Linux y en Software Libre"
http://www.linalco.com Tel: +34-91-5970074 Fax: +34-91-5970083
