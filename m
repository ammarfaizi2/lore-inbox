Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264612AbTIDCuv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 22:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264616AbTIDCuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 22:50:50 -0400
Received: from miranda.zianet.com ([216.234.192.169]:64262 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S264612AbTIDCt6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 22:49:58 -0400
Subject: Re: Scaling noise
From: Steven Cole <elenstev@mesatop.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Larry McVoy <lm@work.bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Brown, Len" <len.brown@intel.com>, Giuliano Pochini <pochini@shiny.it>,
       Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <7420000.1062642672@[10.10.2.4]>
References: <20030903180547.GD5769@work.bitmover.com>
	 <20030903181550.GR4306@holomorphy.com>
	 <1062613931.19982.26.camel@dhcp23.swansea.linux.org.uk>
	 <20030903194658.GC1715@holomorphy.com> <105370000.1062622139@flay>
	 <20030903212119.GX4306@holomorphy.com> <115070000.1062624541@flay>
	 <20030903215135.GY4306@holomorphy.com> <116940000.1062625566@flay>
	 <20030904010653.GD5227@work.bitmover.com>
	 <20030904013253.GB4306@holomorphy.com>  <7420000.1062642672@[10.10.2.4]>
Content-Type: text/plain
Organization: 
Message-Id: <1062643711.3477.90.camel@spc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 03 Sep 2003 20:48:32 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-03 at 20:31, Martin J. Bligh wrote:

> I don't think the initial development baby-steps are *too* bad, and don't
> even have to be done on a NUMA box - a pair of PCs connected by 100baseT
> would work. Personally, I think the first step is to do task migration - 
> migrate a process without it realising from one linux instance to another. 
> Start without the more complex bits like shared filehandles, etc. Something 
> that just writes 1,2,3,4 to a file. It could even just use shared root NFS, 
> I think that works already.
> 
> Basically swap it out on one node, and in on another, though obviously
> there's more state to take across than just RAM. I was talking to Tridge
> the other day, and he said someone had hacked up something in userspace
> which kinda worked ... I'll get some details.
> 

This project may be applicable: http://bproc.sourceforge.net/
BProc is used here: http://www.lanl.gov/projects/pink/

Steven

