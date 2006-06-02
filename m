Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWFBSPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWFBSPV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 14:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWFBSPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 14:15:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59615 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751368AbWFBSPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 14:15:20 -0400
Date: Fri, 2 Jun 2006 11:15:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: jbeulich@novell.com, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] fall back to old-style call trace if no unwinding
 is possible
Message-Id: <20060602111506.e97b2a71.akpm@osdl.org>
In-Reply-To: <20060602115709.GA29066@elte.hu>
References: <448042C1.76E4.0078.0@novell.com>
	<20060602115709.GA29066@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2006 13:57:09 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> hm, could you please merge this ontop of the stacktrace-output 
> beautification patch below that Andrew already has in his post-mm2 tree? 

Is OK - it's better that Jan's new patches apply directly to his present
ones.  I merged them in that order, fixed up the fallout.

