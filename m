Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbTI3OB1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 10:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbTI3OB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 10:01:27 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:18793 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261492AbTI3OB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 10:01:26 -0400
Date: Tue, 30 Sep 2003 15:01:02 +0100
From: Dave Jones <davej@redhat.com>
To: Jan De Luyck <lkml@kcore.org>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.23-pre3] Cache size for Centrino CPU incorrect
Message-ID: <20030930140102.GA12812@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jan De Luyck <lkml@kcore.org>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	linux-kernel@vger.kernel.org
References: <7F740D512C7C1046AB53446D3720017304A790@scsmsx402.sc.intel.com> <200309301423.18378.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309301423.18378.lkml@kcore.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 02:23:15PM +0200, Jan De Luyck wrote:

 > > --- linux-2.4.21/arch/i386/kernel/setup.c	2003-06-13
 > > 07:51:29.000000000 -0700
 > > +++ new/arch/i386/kernel/setup.c	2003-07-08 17:21:48.000000000
 > > -0700
 > > @@ -2246,6 +2249,8 @@
 > >  	{ 0x83, LVL_2,      512 },
 > >  	{ 0x84, LVL_2,      1024 },
 > >  	{ 0x85, LVL_2,      2048 },
 > > +	{ 0x86, LVL_2,      512 },
 > > +	{ 0x87, LVL_2,      1024 },
 > >  	{ 0x00, 0, 0}
 > >  };
 > >
 > This works like a charm. Thanks. Maybe for inclusion in 2.4.23-pre6?

If someone cares enough. I got tired of pushing that patch since 2.4.21.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
