Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263402AbTEIURn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 16:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263427AbTEIURn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 16:17:43 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:22364 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S263402AbTEIURl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 16:17:41 -0400
Subject: Re: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1052503920.2093.5.camel@diemos>
References: <1052323940.2360.7.camel@diemos>
	 <1052336482.2020.8.camel@diemos> <20030507152856.2a71601d.akpm@digeo.com>
	 <1052402187.1995.13.camel@diemos>  <20030508122205.7b4b8a02.akpm@digeo.com>
	 <1052503920.2093.5.camel@diemos>
Content-Type: text/plain
Organization: 
Message-Id: <1052512235.2997.8.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 09 May 2003 15:30:36 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-09 at 13:12, Paul Fulghum wrote:
> On Thu, 2003-05-08 at 14:22, Andrew Morton wrote:
> > Can you pinpoint a kernel version at which it started to happen?
> 
> I have now isolated the latency problems further to 2.5.68-bk11
> 
> 2.5.68-bk10 an earlier works fine.

In the process of eliminating kernel options to isolate
the problem, eliminating USB completely appears to fix it.

One machine (server) was using usb-uhci and
the other (laptop) was using usb-ohci.

So it looks like something with USB in 2.5.68-bk11

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


