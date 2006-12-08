Return-Path: <linux-kernel-owner+w=401wt.eu-S1425636AbWLHQy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425636AbWLHQy5 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 11:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425628AbWLHQy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 11:54:56 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:40541 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1425632AbWLHQyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 11:54:54 -0500
Date: Fri, 8 Dec 2006 08:53:22 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, David Howells <dhowells@redhat.com>,
       torvalds@osdl.org, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it
In-Reply-To: <20061208164733.GE31068@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0612080848220.15847@schroedinger.engr.sgi.com>
References: <20061206190025.GC9959@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com>
 <20061206195820.GA15281@flint.arm.linux.org.uk> <4577DF5C.5070701@yahoo.com.au>
 <20061207150303.GB1255@flint.arm.linux.org.uk> <4578BD7C.4050703@yahoo.com.au>
 <20061208085634.GA25751@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0612080758120.15242@schroedinger.engr.sgi.com>
 <20061208163127.GD31068@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0612080841560.15472@schroedinger.engr.sgi.com>
 <20061208164733.GE31068@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2006, Russell King wrote:

> > Not having cmpxchg is even worse because it requires the introduction and 
> > maintenance of large sets of arch specific operations. Much more complex.
> 
> And which bit of "not available on many architectures" have you not grasped
> yet?

We discussed various forms of emulating that functionality on this thread. 
Seems to work satisfactorily. You can discover the information you skipped 
by going back to some earlier messages of this thread.




