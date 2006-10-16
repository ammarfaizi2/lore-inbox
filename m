Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751529AbWJPL2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbWJPL2s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 07:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbWJPL2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 07:28:48 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:43990 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1751529AbWJPL2r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 07:28:47 -0400
Date: Mon, 16 Oct 2006 04:28:32 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add X86_FEATURE_PEBS and detection
Message-ID: <20061016112832.GE15540@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20061006091006.GD8793@frankl.hpl.hp.com> <200610161209.19503.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610161209.19503.ak@suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 12:09:19PM +0200, Andi Kleen wrote:
> On Friday 06 October 2006 11:10, Stephane Eranian wrote:
> > Hello,
> > 
> > Here is a patch (used by perfmon2) to detect the presence of the
> > Precise Event Based Sampling (PEBS) feature for Intel 64-bit processors.
> > The patch also adds the cpu_has_pebs macro.
> > 
> > IMPORTANT: you need to have the X86_FEATURE_DS renaming patch applied first!
> 
> Added both thanks. I suppose similar i386 patches will be needed too.
> 
Yes (take 32-bit P4 for instance), I submitted them to LML already.

> If you have patches that depend on each other please number
> them in the future.
> 

Ok.

-- 
-Stephane
