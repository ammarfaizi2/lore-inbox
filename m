Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290228AbSCGB6V>; Wed, 6 Mar 2002 20:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290277AbSCGB6L>; Wed, 6 Mar 2002 20:58:11 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:20145 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S290228AbSCGB55>; Wed, 6 Mar 2002 20:57:57 -0500
Date: Wed, 06 Mar 2002 17:57:57 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: early ioremap not working with 2.4.19-pre1-aa1 ?
Message-ID: <76150000.1015466277@flay>
In-Reply-To: <20020302034448.M4431@inspiron.random>
In-Reply-To: <174730000.1015026374@flay> <20020302034448.M4431@inspiron.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I have code for the NUMA-Q systems that does an ioremap
>> as the first thing in smp_boot_cpus (ia32 tree). This seems to 
>> work fine until I install the aa patches ... then it hangs in the 
>> ioremap.
> 
> this sounds like the same problem of the MXT patch. In short pte_alloc
> and in turn ioremap was usable only after the initcalls.
> 
> Does this incremental patch fix it?  (untested)

Sorry for the slow test cycle - this works just great ... will
this make it back to your main tree?

Thanks very much for the patch,

Martin.

