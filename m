Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263459AbTCNSaR>; Fri, 14 Mar 2003 13:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263460AbTCNSaR>; Fri, 14 Mar 2003 13:30:17 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:64495 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263459AbTCNSaQ>; Fri, 14 Mar 2003 13:30:16 -0500
Date: Fri, 14 Mar 2003 10:31:18 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Gregory K. Ruiz-Ade" <gregory@castandcrew.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 instability on bigmem systems?
Message-ID: <127170000.1047666678@flay>
In-Reply-To: <200303131627.22572.gregory@castandcrew.com>
References: <200303131627.22572.gregory@castandcrew.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The primary problem:  Whenever any process (or set of processes) initiates 
> intensive disk I/O, the system grinds to a halt, kswapd and kupdated 
> consume upwards of 40% to 60% CPU each, and system load averages can jump 
> upwards of 21.00.  The problem can be replicated with a simple find command 
> ("find / -print" seems to do it nicely).

Well known set of problems. 
2.4 vm sucks on big machines. Run 2.5, 2.4-aa, or UL.

Yes, you can spend a few weeks beating your head against a brick wall 
gathering various bugfixes if you like ... but you'll probably just end
up with a sore head ...

M.

