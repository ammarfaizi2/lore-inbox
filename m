Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbVHLSiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbVHLSiP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbVHLSiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:38:14 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:3521 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750909AbVHLSiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:38:13 -0400
Date: Fri, 12 Aug 2005 20:37:40 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Linus Torvalds <torvalds@osdl.org>, Chris Wright <chrisw@osdl.org>,
       gdt@linuxppc.org, Andrew Morton <akpm@osdl.org>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       linux-kernel@vger.kernel.org, Robert Wilkens <robw@optonline.net>
Subject: Re: [PATCH] Fix PPC signal handling of NODEFER, should not affect
 sa_mask
In-Reply-To: <1123643401.9553.32.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0508122036500.16845@yvahk01.tjqt.qr>
References: <42F8EB66.8020002@fujitsu-siemens.com> 
 <1123612016.3167.3.camel@localhost.localdomain>  <42F8F6CC.7090709@fujitsu-siemens.com>
  <1123612789.3167.9.camel@localhost.localdomain>  <42F8F98B.3080908@fujitsu-siemens.com>
  <1123614253.3167.18.camel@localhost.localdomain> 
 <1123615983.18332.194.camel@localhost.localdomain>  <42F906EB.6060106@fujitsu-siemens.com>
  <1123617812.18332.199.camel@localhost.localdomain> 
 <1123618745.18332.204.camel@localhost.localdomain>  <20050809204928.GH7991@shell0.pdx.osdl.net>
  <1123621223.9553.4.camel@localhost.localdomain>  <1123621637.9553.7.camel@localhost.localdomain>
  <Pine.LNX.4.58.0508091419420.3258@g5.osdl.org> <1123643401.9553.32.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Actually I take it the other way.  The wording is awful. But the "unless
>SA_NODEFER or SA_RESETHAND is set, and then including the signal being
>delivered".  This looks to me that it adds the signal being delivered to
>the blocked mask unless the SA_NODEFER or SA_RESETHAND is set. I kind of
>wonder if English is the native language of those that wrote this.  

So, if in doubt what is really meant - check which of the two/three/+ 
different behaviors the users out there favor most.



Jan Engelhardt
-- 
