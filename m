Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946681AbWKJOB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946681AbWKJOB6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 09:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946670AbWKJOB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 09:01:58 -0500
Received: from cantor2.suse.de ([195.135.220.15]:41651 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1946673AbWKJOB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 09:01:57 -0500
From: Andi Kleen <ak@suse.de>
To: Alexander van Heukelum <heukelum@mailshack.com>
Subject: Re: [PATCH] shorten the x86_64 boot setup GDT to what the comment says
Date: Fri, 10 Nov 2006 15:01:39 +0100
User-Agent: KMail/1.9.5
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
       sct@redhat.com, herbert@gondor.apana.org.au,
       xen-devel@lists.xensource.com
References: <Pine.LNX.4.58.0611082144410.17812@gandalf.stny.rr.com> <200611091433.09232.ak@suse.de> <20061109183111.GA32438@mailshack.com>
In-Reply-To: <20061109183111.GA32438@mailshack.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611101501.40007.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi Andi,
> 
> (Assuming you mean: "The gdt table already is 16-byte aligned.")
> 
> Hmm. Not in the most recent version of Linus' tree, not even by
> concidence, and none of the patches in your quilt-current/patches touch
> x86_64's version of setup.S. Am I missing something?

The main GDT is. The boot GDT isn't, but it doesn't matter because
it is only used for a very short time.

-Andi

