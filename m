Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264579AbUGBORQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264579AbUGBORQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 10:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264578AbUGBORP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 10:17:15 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:52068 "EHLO
	zircon.austin.ibm.com") by vger.kernel.org with ESMTP
	id S264609AbUGBOPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 10:15:42 -0400
In-Reply-To: <16613.15510.325099.273419@cargo.ozlabs.ibm.com>
References: <20040629191046.Q21634@forte.austin.ibm.com> <16610.39955.554139.858593@cargo.ozlabs.ibm.com> <20040701160614.I21634@forte.austin.ibm.com> <16613.15510.325099.273419@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3EC84E0C-CC32-11D8-BDBD-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
Cc: linas@austin.ibm.com, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [PATCH] [2.6] PPC64: log firmware errors during boot.
Date: Fri, 2 Jul 2004 09:15:18 -0500
To: Paul Mackerras <paulus@samba.org>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 2, 2004, at 5:44 AM, Paul Mackerras wrote:
>
> Netlink is the usual solution to this sort of problem.  I think it
> would be reasonable to printk RTAS error events with a severity of
> fatal and maybe even of error.  Warnings and events should just get
> sent to rtasd.

I asked about this before, and was told that there is no way to 
determine the severity of an event without doing full parsing of the 
binary data. I'd be thrilled to be wrong...

-- 
Hollis Blanchard
IBM Linux Technology Center

