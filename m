Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbVHKVY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbVHKVY2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 17:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbVHKVY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 17:24:27 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:7076 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750877AbVHKVY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 17:24:27 -0400
Date: Thu, 11 Aug 2005 16:22:09 -0500
From: serue@us.ibm.com
To: James Morris <jmorris@namei.org>
Cc: serue@us.ibm.com, lkml <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Stacker - single-use static slots
Message-ID: <20050811212209.GB28004@serge.austin.ibm.com>
References: <20050727181732.GA22483@serge.austin.ibm.com> <Lynx.SEL.4.62.0507271527390.1844@thoron.boston.redhat.com> <Lynx.SEL.4.62.0507271535150.1844@thoron.boston.redhat.com> <20050803164516.GB13691@serge.austin.ibm.com> <Lynx.SEL.4.62.0508051154150.8981@thoron.boston.redhat.com> <20050810144516.GA5796@serge.austin.ibm.com> <Pine.LNX.4.63.0508110331250.27749@excalibur.intercode>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0508110331250.27749@excalibur.intercode>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting James Morris (jmorris@namei.org):
> On Wed, 10 Aug 2005, serue@us.ibm.com wrote:
> 
> > those annoying cache effects, I assume - 3 slots (the default)
> > outperforms two slots, even though only one slot is being used.  These
> > tests were run on a 16-way power4+ system.  I may try to re-run on some
> > x86 hardware, though each run will probably take 24 hours.
> 
> I've also run some benchmarks, comparing vanilla kernel with the 
> two stacker approaches.  Results below.
> 
> Results seem to be mixed, sometimes a bit better, sometimes a bit worse.  
> The macro benchmarks tend to show better figures for the static slot 
> model.
> 
> Overall, it seems that SELinux could expect to take a 1-2% performance hit 
> with the stacker.

Thanks, James.

I guess I should do some profiling runs - I'm surprised there would be
this much of a hit with the static slots.

thanks,
-serge
