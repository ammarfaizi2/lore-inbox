Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbTEUWnw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 18:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbTEUWnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 18:43:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:31960 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262297AbTEUWnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 18:43:51 -0400
Date: Wed, 21 May 2003 15:55:16 -0700 (PDT)
Message-Id: <20030521.155516.41646323.davem@redhat.com>
To: mbligh@aracnet.com
Cc: habanero@us.ibm.com, haveblue@us.ibm.com, wli@holomorphy.com,
       arjanv@redhat.com, pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       gh@us.ibm.com, johnstul@us.ibm.com, jamesclv@us.ibm.com, akpm@digeo.com,
       mannthey@us.ibm.com
Subject: Re: userspace irq balancer
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <6610000.1053529089@[10.10.2.4]>
References: <200305200907.41443.habanero@us.ibm.com>
	<20030520.163833.104040023.davem@redhat.com>
	<6610000.1053529089@[10.10.2.4]>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Martin J. Bligh" <mbligh@aracnet.com>
   Date: Wed, 21 May 2003 07:58:11 -0700
   
   Despite whatever political wrangling there is between userspace and
   kernelspace implementations (and some very valid points about other
   arches), there is still a dearth of testing, as far as I can see.

I've never in my life heard the argument that we kept something
in the kernel that didn't belong there due to "userland testing".
That's a bogus argument.

When I ripped RARP out of the kernel, we didn't immediately have
a replacement, but one showed up shortly.  So what?

And in this ase we already have Arjan's stuff.  So start testing
his code instead of whining about keeping the current stuff in
the tree.
