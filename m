Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264145AbTE0UvV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 16:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264125AbTE0UvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 16:51:20 -0400
Received: from ns.suse.de ([213.95.15.193]:32018 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264145AbTE0UvT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 16:51:19 -0400
Date: Tue, 27 May 2003 23:04:33 +0200
From: Andi Kleen <ak@suse.de>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Andi Kleen <ak@suse.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make ACPI compile again on 64bit/gcc 3.3 II
Message-ID: <20030527210433.GH27568@wotan.suse.de>
References: <F760B14C9561B941B89469F59BA3A847E96EDE@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E96EDE@orsmsx401.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 01:31:57PM -0700, Grover, Andrew wrote:
> > From: Andi Kleen [mailto:ak@suse.de] 
> > Sent: Saturday, May 24, 2003 3:40 PM
> > To: Grover, Andrew
> > Cc: Andi Kleen; torvalds@transmeta.com; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] Make ACPI compile again on 64bit/gcc 3.3 II
> > 
> > 
> > On Sat, May 24, 2003 at 01:55:26PM -0700, Grover, Andrew wrote:
> > > Actually, I think osl.c should be changed to match the header as it
> > > stands. Could you try that and see if that also fixes things?
> > 
> > On looking again these functions are not used at all.
> > How about just removing them? 
> 
> We will remove them for the next release.

But can you merge one of the patches for now to make it compile again?

-Andi
