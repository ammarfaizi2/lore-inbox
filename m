Return-Path: <linux-kernel-owner+w=401wt.eu-S1425619AbWLHQn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425619AbWLHQn3 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 11:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425618AbWLHQn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 11:43:29 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:37309 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1425616AbWLHQn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 11:43:27 -0500
Date: Fri, 8 Dec 2006 08:43:09 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, David Howells <dhowells@redhat.com>,
       torvalds@osdl.org, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it
In-Reply-To: <20061208163127.GD31068@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0612080841560.15472@schroedinger.engr.sgi.com>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com>
 <20061206190025.GC9959@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com>
 <20061206195820.GA15281@flint.arm.linux.org.uk> <4577DF5C.5070701@yahoo.com.au>
 <20061207150303.GB1255@flint.arm.linux.org.uk> <4578BD7C.4050703@yahoo.com.au>
 <20061208085634.GA25751@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0612080758120.15242@schroedinger.engr.sgi.com>
 <20061208163127.GD31068@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2006, Russell King wrote:

> You're advocating cmpxchg is adopted by all architectures.  It isn't
> available on many architectures, and those which it can be requires
> unnecessarily complicated coding.

Not having cmpxchg is even worse because it requires the introduction and 
maintenance of large sets of arch specific operations. Much more complex.


