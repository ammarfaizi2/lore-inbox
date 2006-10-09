Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751723AbWJIPzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbWJIPzS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 11:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbWJIPzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 11:55:17 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:27325 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751723AbWJIPzQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 11:55:16 -0400
Subject: Re: 2.6.18-mm3: Panic during boot on NUMA-Q
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1160408385.8205.4.camel@localhost.localdomain>
References: <20061006235937.GA13241@us.ibm.com>
	 <1160408385.8205.4.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 08:54:53 -0700
Message-Id: <1160409293.17103.1.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-09 at 08:39 -0700, Dave Hansen wrote:
> On Fri, 2006-10-06 at 16:59 -0700, Sukadev Bhattiprolu wrote:
> > Panic on boot with 2.6.18-mm3 on 4-CPU (PIII, 700Mhz) NUMAQ system.
> > 
> > This machine boots fine with 2.6.18-mm1 with an almost identical config
> > file.
> > 
> > config file, lspci-vvv and complete dmesg attached. 
> > 
> > Pls let me know if you need more info.
> 
> It would be really helpful to isolate down where this started happening?
> Did it occur in -mm2?  mainline 2.6.18?
> 
> If you can isolate it to -mm, try a bisection.

Martin reported the same on -mm2.

Thanks,
Badari

