Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264828AbUE0Pxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264828AbUE0Pxc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 11:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264837AbUE0Pxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 11:53:32 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:4480 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264828AbUE0Pxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 11:53:30 -0400
Date: Thu, 27 May 2004 16:59:52 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200405271559.i4RFxqN3000359@81-2-122-30.bradfords.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>,
       "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
Cc: Andy Lutomirski <luto@myrealbox.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Tom Felker <tcfelker@mtco.com>,
       Matthias Schniedermeyer <ms@citd.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20040527124145.GD22648@holomorphy.com>
References: <5D3C2276FD64424297729EB733ED1F7606242C53@email1.mitretek.org>
 <20040527124145.GD22648@holomorphy.com>
Subject: Re: why swap at all?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from William Lee Irwin III <wli@holomorphy.com>:
> On Thu, May 27, 2004 at 08:31:26AM -0400, Piszcz, Justin Michael wrote:
> > If I have 16GB of ram should I use swap?
> > Would swap cause the machine to slow down?
> 
> Yes. You want swap so you can physically relocate anonymous pages in the
> rare case one ends up somewhere it could cause memory pressure against
> allocations that can only be satisfied by a restricted range of memory.

I think you are assuming a 100% perfect VM system.  In practice, if the machine
isn't heavily loaded, unnecessary swap is more likely to cause, (slight, and
possibly negligable), slowdowns, than bring any noticable performance benefit.

John.
