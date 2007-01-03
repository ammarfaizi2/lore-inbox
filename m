Return-Path: <linux-kernel-owner+w=401wt.eu-S1750794AbXACOTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbXACOTJ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 09:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbXACOTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 09:19:09 -0500
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:1639 "EHLO
	kraid.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750794AbXACOTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 09:19:07 -0500
Date: Wed, 3 Jan 2007 15:18:59 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Vivek Goyal <vgoyal@in.ibm.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@muc.de>,
       Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] i386 kernel instant reboot with older binutils fix
Message-Id: <20070103151859.4f1e2937.khali@linux-fr.org>
In-Reply-To: <20070103135326.GF20714@stusta.de>
References: <20070103041645.GA17546@in.ibm.com>
	<20070103135326.GF20714@stusta.de>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2007 14:53:26 +0100, Adrian Bunk wrote:
> On Wed, Jan 03, 2007 at 09:46:45AM +0530, Vivek Goyal wrote:
> > 
> > o i386 kernel reboots instantly if compiled with binutils older than
> >   2.6.15.
> 
> Should that have been "2.15"?
> 
> And is the following perhaps the same issue?
> 
> Subject    : kernel immediately reboots instead of booting
> References : http://lkml.org/lkml/2007/1/2/15
> Submitter  : Steve Youngs <steve@youngs.au.com>
> Status     : unknown

Indeed this pretty much resembles my problem.

> @Steve:
> You had binutils 2.14.90.0.6 .
> Does this patch fix it for you?

I'd really expect it to, Steve please try the patch and confirm.

-- 
Jean Delvare
