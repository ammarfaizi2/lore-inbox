Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319139AbSIKPSi>; Wed, 11 Sep 2002 11:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319152AbSIKPSh>; Wed, 11 Sep 2002 11:18:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:44467 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319139AbSIKPSh>;
	Wed, 11 Sep 2002 11:18:37 -0400
Date: Wed, 11 Sep 2002 08:15:21 -0700 (PDT)
Message-Id: <20020911.081521.103561835.davem@redhat.com>
To: ebiederm@xmission.com
Cc: mbligh@aracnet.com, hadi@cyberus.ca, tcw@tempest.prismnet.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, niv@us.ibm.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <m1d6rko9ab.fsf@frodo.biederman.org>
References: <m1hegwoppm.fsf@frodo.biederman.org>
	<477096648.1031728254@[10.10.2.3]>
	<m1d6rko9ab.fsf@frodo.biederman.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: ebiederm@xmission.com (Eric W. Biederman)
   Date: 11 Sep 2002 09:06:36 -0600

   "Martin J. Bligh" <mbligh@aracnet.com> writes:
   
   > We can push about 420MB/s of IO out of this thing (out of that 
   > theoretical 800Mb/s). 
   
   Sounds about average for a P3.  I have pushed the full 800MiB/s out of
   a P3 processor to memory but it was a very optimized loop.

You pushed that over the PCI bus of your P3?  Just to RAM
doesn't count, lots of cpu's can do that.

That's what makes his number interesting.
