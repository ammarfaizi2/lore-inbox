Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752060AbWCGGrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbWCGGrb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 01:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbWCGGrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 01:47:31 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:40153
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1752060AbWCGGra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 01:47:30 -0500
Date: Mon, 06 Mar 2006 22:47:48 -0800 (PST)
Message-Id: <20060306.224748.86458359.davem@davemloft.net>
To: dipankar@in.ibm.com
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, fabbione@ubuntu.com,
       akpm@osdl.org
Subject: Re: VFS nr_files accounting
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060307064120.GA5946@in.ibm.com>
References: <20060305113847.GE21751@in.ibm.com>
	<20060306.123904.35238417.davem@davemloft.net>
	<20060307064120.GA5946@in.ibm.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dipankar Sarma <dipankar@in.ibm.com>
Date: Tue, 7 Mar 2006 12:11:20 +0530

> On Mon, Mar 06, 2006 at 12:39:04PM -0800, David S. Miller wrote:
> > I think we should seriously consider these patches for 2.6.16
> 
> Isn't it a little too late in the 2.6.16 cycle ? I would have
> liked a little more time in -mm. Anyway, it is Linus' call. 
> I can refresh the patches and submit against latest mainline
> if Linus and Andrew want.

Users can run widely published programs to make one's system run out
of file descriptors and make the machine totaly unusable.

If that doesn't qualify for something to fix for 2.6.16 I don't know
what does.  :-)
