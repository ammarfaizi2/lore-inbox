Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266720AbTAIOHj>; Thu, 9 Jan 2003 09:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266721AbTAIOHj>; Thu, 9 Jan 2003 09:07:39 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:45952 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266720AbTAIOHi>;
	Thu, 9 Jan 2003 09:07:38 -0500
Date: Thu, 9 Jan 2003 19:57:59 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: arnd@bergmann-dalldorf.de
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "David S. Miller " <davem@redhat.com>
Subject: Re: [IPV6]: Convert mibstats to use kmalloc_percpu
Message-ID: <20030109142759.GK31855@in.ibm.com>
References: <200301081718.37263.arndb@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301081718.37263.arndb@de.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This does not work when cleanup_ipv6_mibs() is marked __exit,
> the fix below is needed to build a kernel with ipv6.

Yes, it should not have been marked __exit.
Thanks for the patch
Dave, Plase apply.

Thanks,
Kiran

