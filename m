Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264502AbUG2MZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbUG2MZa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 08:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264524AbUG2MZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 08:25:30 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:14302 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264502AbUG2MYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 08:24:14 -0400
Subject: Re: Oops in find_busiest_group(): 2.6.8-rc1-mm1
From: Dave Hansen <haveblue@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Paul Jackson <pj@sgi.com>,
       PPC64 External List <linuxppc64-dev@lists.linuxppc.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jesse Barnes <jbarnes@sgi.com>
In-Reply-To: <4108D349.1030209@yahoo.com.au>
References: <1089871489.10000.388.camel@nighthawk>
	 <20040728234255.29ef4c13.pj@sgi.com>	<4108B66D.1050000@yahoo.com.au>
	 <20040729022912.04a0806d.pj@sgi.com>  <4108D349.1030209@yahoo.com.au>
Content-Type: text/plain
Message-Id: <1091103772.2871.1499.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 29 Jul 2004 05:22:52 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-29 at 03:36, Nick Piggin wrote:
> Hmm, nothing else seems to be oopsing. Maybe it is the ia64
> domain setup code that Jesse did? The domains/groups must
> not have been built properly somewhere.

Does backing this patch out help?  It did on ppc64.

http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc1/2.6.8-rc1-mm1/broken-out/detect-too-early-schedule-attempts.patch

-- Dave

