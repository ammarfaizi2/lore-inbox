Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752020AbWCGHJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbWCGHJW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 02:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752079AbWCGHJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 02:09:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53978 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752020AbWCGHJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 02:09:21 -0500
Date: Mon, 6 Mar 2006 23:06:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: dipankar@in.ibm.com
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       fabbione@ubuntu.com
Subject: Re: VFS nr_files accounting
Message-Id: <20060306230639.24eacb6c.akpm@osdl.org>
In-Reply-To: <20060307064120.GA5946@in.ibm.com>
References: <20060305070537.GB21751@in.ibm.com>
	<20060304.233725.49897411.davem@davemloft.net>
	<20060305113847.GE21751@in.ibm.com>
	<20060306.123904.35238417.davem@davemloft.net>
	<20060307064120.GA5946@in.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma <dipankar@in.ibm.com> wrote:
>
>  > I think we should seriously consider these patches for 2.6.16
> 
>  Isn't it a little too late in the 2.6.16 cycle ? I would have
>  liked a little more time in -mm. Anyway, it is Linus' call. 
>  I can refresh the patches and submit against latest mainline
>  if Linus and Andrew want.

I'd view a 2.6.16 merge as relatively low-risk.  My main concern would be
possible breakage of those whacky route-cache workloads.

(I've consoldidated the patches and rebased them against mainline).
