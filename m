Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424173AbWKISPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424173AbWKISPK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 13:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424183AbWKISPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 13:15:10 -0500
Received: from justus.rz.uni-saarland.de ([134.96.7.31]:22514 "EHLO
	justus.rz.uni-saarland.de") by vger.kernel.org with ESMTP
	id S1424173AbWKISPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 13:15:08 -0500
Date: Thu, 9 Nov 2006 19:31:11 +0100
From: Alexander van Heukelum <heukelum@mailshack.com>
To: Andi Kleen <ak@suse.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
       sct@redhat.com, herbert@gondor.apana.org.au,
       xen-devel@lists.xensource.com
Subject: Re: [PATCH] shorten the x86_64 boot setup GDT to what the comment says
Message-ID: <20061109183111.GA32438@mailshack.com>
References: <Pine.LNX.4.58.0611082144410.17812@gandalf.stny.rr.com> <Pine.LNX.4.58.0611091016100.6250@gandalf.stny.rr.com> <20061109154436.GA31954@mailshack.com> <200611091433.09232.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611091433.09232.ak@suse.de>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.1 (justus.rz.uni-saarland.de [134.96.7.31]); Thu, 09 Nov 2006 19:15:06 +0100 (CET)
X-AntiVirus: checked by AntiVir Milter (version: 1.1.3-1; AVE: 7.2.0.39; VDF: 6.36.1.11; host: AntiVir1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2006 at 02:33:08PM +0100, Andi Kleen wrote:
> 
> > Maybe you should consider 16-byte aligning the gdt table too, like
> > i386 does? It doesn't hurt, and as per the comment in the i386-file
> > "16 byte aligment is recommended by intel."
> 
> It already is.

Hi Andi,

(Assuming you mean: "The gdt table already is 16-byte aligned.")

Hmm. Not in the most recent version of Linus' tree, not even by
concidence, and none of the patches in your quilt-current/patches touch
x86_64's version of setup.S. Am I missing something?

Alexander

> -Andi
> 

-- 
Alexander van Heukelum
