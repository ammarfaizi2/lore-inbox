Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWFCIW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWFCIW2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 04:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWFCIW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 04:22:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26276 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751470AbWFCIW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 04:22:27 -0400
Date: Sat, 3 Jun 2006 01:22:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, mason@suse.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] fix smt nice lock contention and optimization
Message-Id: <20060603012212.5edac4d0.akpm@osdl.org>
In-Reply-To: <000901c686e6$225abd90$df34030a@amr.corp.intel.com>
References: <20060603011107.4c6de627.akpm@osdl.org>
	<000901c686e6$225abd90$df34030a@amr.corp.intel.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Jun 2006 01:17:19 -0700
"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:

> Andrew Morton wrote on Saturday, June 03, 2006 1:11 AM
> > Ingo Molnar <mingo@elte.hu> wrote:
> > > looks really good now to me.
> > > 
> > >  Signed-off-by: Ingo Molnar <mingo@elte.hu>
> > > 
> > > lets try it in -mm?
> > > 
> > 
> > Yup.  I redid Ken's patch against mainline and them mangled
> > lock-validator-special-locking-schedc.patch to suit.
> 
> Hmm, wish I knew this beforehand, so that I won't spend extra 1/2
> hour to port the patch to -mm and only to have you convert it back
> to mainline. I could just post the version I originally had against
> the mainline.
> 

Unless you're specifically working against code which is only in -mm (or a
subsystem tree), please work against mainline.

