Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422953AbWJQABy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422953AbWJQABy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 20:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422959AbWJQABy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 20:01:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59588 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422953AbWJQABw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 20:01:52 -0400
Date: Mon, 16 Oct 2006 16:58:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: vgoyal@in.ibm.com
Cc: Steve Fox <drfickle@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Badari Pulavarty <pbadari@us.ibm.com>, Martin Bligh <mbligh@mbligh.org>,
       lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       kmannth@us.ibm.com, Andy Whitcroft <apw@shadowen.org>,
       Adrian Bunk <bunk@stusta.de>, Mel Gorman <mel@csn.ul.ie>
Subject: Re: 2.6.18-mm2 boot failure on x86-64
Message-Id: <20061016165814.13b99e5e.akpm@osdl.org>
In-Reply-To: <20061016181613.GA30090@in.ibm.com>
References: <200610052105.00359.ak@suse.de>
	<1160080954.29690.44.camel@flooterbu>
	<200610052250.55146.ak@suse.de>
	<1160101394.29690.48.camel@flooterbu>
	<20061006143312.GB9881@skynet.ie>
	<20061006153629.GA19756@in.ibm.com>
	<20061006171105.GC9881@skynet.ie>
	<1160157830.29690.66.camel@flooterbu>
	<20061006200436.GG19756@in.ibm.com>
	<Pine.LNX.4.64.0610091049390.30765@skynet.skynet.ie>
	<20061016181613.GA30090@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006 14:16:13 -0400
Vivek Goyal <vgoyal@in.ibm.com> wrote:

> 
> Can you please have a look at the attached patch

Looks like a fine patch to me, although it could benefit from a comment
explaining why all those PAGE_ALIGN()s are in there.

> and include it in -mm.

Does it fix a patch in -mm or is it needed in mainline?


