Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262083AbSJDViX>; Fri, 4 Oct 2002 17:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262085AbSJDViW>; Fri, 4 Oct 2002 17:38:22 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:15889
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262083AbSJDViQ>; Fri, 4 Oct 2002 17:38:16 -0400
Subject: Re: [PATCH] patch-slab-split-03-tail
From: Robert Love <rml@tech9.net>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com
In-Reply-To: <3D9E0760.8040507@colorfullife.com>
References: <Pine.LNX.4.33L2.0210041321370.20655-100000@dragon.pdx.osdl.net> 
	<3D9E0760.8040507@colorfullife.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Oct 2002 17:43:58 -0400
Message-Id: <1033767839.1247.107.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-04 at 17:25, Manfred Spraul wrote:

> Which cpus have slow local_irq_disable() implementations? At least
> for  my Duron, this doesn't seem to be the case [~ 4 cpu cycles
> for cli]

I believe there are pipeline effects to disabling interrupts, e.g. it
has to be flushed?

	Robert Love

