Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbUKVQ6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbUKVQ6Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbUKVQzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:55:51 -0500
Received: from cantor.suse.de ([195.135.220.2]:50057 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262218AbUKVQyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 11:54:25 -0500
Date: Mon, 22 Nov 2004 17:54:25 +0100
From: Andi Kleen <ak@suse.de>
To: Andreas Schwab <schwab@suse.de>
Cc: Andi Kleen <ak@suse.de>, Ray Bryant <raybry@sgi.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>, holt@sgi.com,
       Dean Roe <roe@sgi.com>, Brian Sumner <bls@sgi.com>,
       John Hawkes <hawkes@tomahawk.engr.sgi.com>
Subject: Re: [Lse-tech] scalability of signal delivery for Posix Threads
Message-ID: <20041122165425.GG21861@wotan.suse.de>
References: <41A20AF3.9030408@sgi.com> <20041122162214.GE21861@wotan.suse.de> <jept25yggg.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jept25yggg.fsf@sykes.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 05:51:59PM +0100, Andreas Schwab wrote:
> Andi Kleen <ak@suse.de> writes:
> 
> > At least in traditional signal semantics you have to call sigaction
> > or signal in each signal handler to reset the signal. So that 
> > assumption is not necessarily true.
> 
> If you use sigaction then you get POSIX semantics, which don't have this
> problem.

It's just a common case where Ray's assumption is not true.

-Andi
