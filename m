Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262674AbTCYOvk>; Tue, 25 Mar 2003 09:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262675AbTCYOvk>; Tue, 25 Mar 2003 09:51:40 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:33711 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262674AbTCYOvj>;
	Tue, 25 Mar 2003 09:51:39 -0500
Message-ID: <3E806EF3.2000301@us.ibm.com>
Date: Tue, 25 Mar 2003 09:00:03 -0600
From: Jon Grimm <jgrimm2@us.ibm.com>
Organization: IBM
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: LKML <linux-kernel@vger.kernel.org>,
       Trivial Kernel Patches <trivial@rustcorp.com.au>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] warning and unused in sctp.h
References: <20030325142400.194987b0.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote:

> Hi,
> 
> This patch changes a flags argument to spin_lock_irq_save to unsigned long
> and removes its unused attribute.  The first gets rid of several warnings
> and the second is "obviously correct" (at least according to Rusty) :-).
> 

Hi Stephen.   What probably isn't obvious is that the same source is 
compiled into a user-level test harness where that variable really _is_ 
unused.  ;-)    However, this was just a hack to get rid of a 
compilation warning in the testsuite, so I'm glad to see it gone.

thanks!
-jon




