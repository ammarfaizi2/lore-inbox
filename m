Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbTEUOpb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 10:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbTEUOpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 10:45:30 -0400
Received: from franka.aracnet.com ([216.99.193.44]:7135 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262143AbTEUOp2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 10:45:28 -0400
Date: Wed, 21 May 2003 07:58:11 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "David S. Miller" <davem@redhat.com>, habanero@us.ibm.com
cc: haveblue@us.ibm.com, wli@holomorphy.com, arjanv@redhat.com,
       pbadari@us.ibm.com, linux-kernel@vger.kernel.org, gh@us.ibm.com,
       johnstul@us.ibm.com, jamesclv@us.ibm.com, akpm@digeo.com,
       mannthey@us.ibm.com
Subject: Re: userspace irq balancer
Message-ID: <6610000.1053529089@[10.10.2.4]>
In-Reply-To: <20030520.163833.104040023.davem@redhat.com>
References: <1053412583.13289.322.camel@nighthawk><20030519.234055.35511478.davem@redhat.com><200305200907.41443.habanero@us.ibm.com> <20030520.163833.104040023.davem@redhat.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is zero reason why IRQ balancing should be in any way
> different.  It's POLICY, and POLICY == USERSPACE.  It is the end
> of the argument.

Despite whatever political wrangling there is between userspace and
kernelspace implementations (and some very valid points about other
arches), there is still a dearth of testing, as far as I can see.

I can't see anything wrong with making it a config option for now,
and letting people choose what they want to do, until we have more
information as to which performs better under a variety of workloads. 
That seems the most pragmatic way forward.

M.

