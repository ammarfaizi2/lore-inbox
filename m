Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263270AbTKCVgX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 16:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbTKCVgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 16:36:22 -0500
Received: from dp.samba.org ([66.70.73.150]:16829 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263270AbTKCVgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 16:36:22 -0500
Date: Tue, 4 Nov 2003 08:32:53 +1100
From: Anton Blanchard <anton@samba.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: 2.6.0-test9-mjb1
Message-ID: <20031103213253.GB13057@krispykreme>
References: <14860000.1067544022@flay> <3FA171DD.5060406@pobox.com> <1067548047.1028.19.camel@nighthawk> <3FA17FEC.2080203@pobox.com> <1067549370.2657.38.camel@nighthawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1067549370.2657.38.camel@nighthawk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Whoops.  I just went looking in the breakout directory and didn't see it
> in there.  I wonder where it was hidden.  
> 
> Anton, did this come from you?  Did it stop some warnings or something?

I think it came from Scott. At one stage ppc64 had 64bit IO BARs, we
have since switched to 32bit BARs but I kept the patch. As Jeff points
out, the old behaviour is a bug.

Anton
