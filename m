Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313179AbSDJObX>; Wed, 10 Apr 2002 10:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313176AbSDJObW>; Wed, 10 Apr 2002 10:31:22 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:19424 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S313175AbSDJObV>; Wed, 10 Apr 2002 10:31:21 -0400
Date: Wed, 10 Apr 2002 07:31:39 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: zxj@water.pku.edu.cn, linux-kernel@vger.kernel.org
Subject: Re: how to balance interrupts between 2 CPUs?
Message-ID: <2065456499.1018423898@[10.10.2.3]>
In-Reply-To: <b5926afe75.afe75b5926@water.pku.edu.cn>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     The kernel's SMP option is enable, but the CPU1 is always idle.
>     How to balance the interrpupts between two CPUs?
>     If you are convenient, please give me some advice quickly.

The P4 apics do not automatically balance interrupts between CPUs.
You need to do it explicitly - there are several ways floating
around to do this - try the APIC routing patch on this website:

http://sourceforge.net/projects/lse

and let us know if this works ...

M.

