Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314494AbSDRXSz>; Thu, 18 Apr 2002 19:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314493AbSDRXSy>; Thu, 18 Apr 2002 19:18:54 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:2473 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314494AbSDRXSb>;
	Thu, 18 Apr 2002 19:18:31 -0400
Message-Id: <200204182315.g3INFRe03944@w-gaughen.des.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
        Martin.Bligh@us.ibm.com, pdorwin@us.ibm.com, rml@tech9.net,
        mingo@elte.hu
Subject: Re: [PATCH] migration_init() synchronization fixes 
In-Reply-To: Message from William Lee Irwin III <wli@holomorphy.com> 
   of "Mon, 15 Apr 2002 17:03:23 PDT." <20020416000323.GQ23767@holomorphy.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 18 Apr 2002 16:15:27 -0700
From: Patricia Gaughen <gone@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  > This patch has helped me and some others having migration_init() troubles.
  > The migration_mask's semantics are altered for use as a lock word, and
  > some of its other functionality is deferred to a new counter and struct
  > completion to provide protection against pathological cases encountered
  > in practice.

Without this patch the 16 proc NUMA-Q box won't boot on 2.5.7/2.5.8.  With the 
patch the system boots. yeah!!!! :-)

Thanks,
Pat

-- 
Patricia Gaughen (gone@us.ibm.com)
IBM Linux Technology Center
http://www.ibm.com/linux/ltc/


