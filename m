Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbTETGZi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 02:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbTETGZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 02:25:38 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:51334 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263580AbTETGZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 02:25:36 -0400
Subject: Re: userspace irq balancer
From: Dave Hansen <haveblue@us.ibm.com>
To: "David S. Miller" <davem@redhat.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>, arjanv@redhat.com,
       Badari Pulavarty <pbadari@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, Gerrit Huizenga <gh@us.ibm.com>,
       John Stultz <johnstul@us.ibm.com>,
       James Cleverdon <jamesclv@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       Keith Mannthey <mannthey@us.ibm.com>
In-Reply-To: <20030519.231319.91314647.davem@redhat.com>
References: <20030520034622.GK8978@holomorphy.com>
	 <1053407030.13207.253.camel@nighthawk> <88560000.1053409990@[10.10.2.4]>
	 <20030519.231319.91314647.davem@redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1053412583.13289.322.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 19 May 2003 23:36:23 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-19 at 23:13, David S. Miller wrote:
>    From: "Martin J. Bligh" <mbligh@aracnet.com>
>    Date: Mon, 19 May 2003 22:53:11 -0700
> 
>    I have no frigging idea why you'd want to tear something out that
>    works well already, and has a shitload of work put into it. 
>    
> It's pretty fundamentally broken for having had so much work
> put into it.  Show me something other than "SpecWEB run for IBM
> ran faster" as a reason for keeping this code in there.  Can you
> even do this?

I don't even think we can do that.  That code was being integrated
around the same time that our Specweb setup decided to go south on us
and start physically frying itself.  We never got a chance to run it. 
BTW, I don't think there are any other kernel developers running Specweb
on 2.5 kernels.  If there are, please speak up!

Andrew Theurer posted some positive results here, which were quite
marginal in the case with 1 nic.  4.7% with two.
http://marc.theaimsgroup.com/?l=linux-kernel&m=104212930819212&w=2


-- 
Dave Hansen
haveblue@us.ibm.com

