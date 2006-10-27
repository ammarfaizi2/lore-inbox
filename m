Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946051AbWJ0HKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946051AbWJ0HKy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 03:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946050AbWJ0HKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 03:10:54 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:27289
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1946051AbWJ0HKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 03:10:53 -0400
Date: Fri, 27 Oct 2006 00:10:37 -0700 (PDT)
Message-Id: <20061027.001037.74128782.davem@davemloft.net>
To: supriyak@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Incorrect order of last two arguments of ptrace for requests
 PPC_PTRACE_GETREGS, SETREGS, GETFPREGS, SETFPREGS
From: David Miller <davem@davemloft.net>
In-Reply-To: <4541B33D.6090704@in.ibm.com>
References: <453F421A.6070507@in.ibm.com>
	<20061025.134354.92582918.davem@davemloft.net>
	<4541B33D.6090704@in.ibm.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: supriya kannery <supriyak@in.ibm.com>
Date: Fri, 27 Oct 2006 12:50:29 +0530

>     I checked in gdb and ltrace code. None of them are using PPC_PTRACE* 
> options to get register values.
> Man page also doesn't mention these options. Once this is fixed, these 
> options could be added to man page also.
> 
> Irrespective of whether we fix this, documentation of these options in 
> manpage will clarify its usage I guess.

Yep.  Are the no current users at all?  That's strange...
