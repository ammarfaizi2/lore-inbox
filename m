Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbTKEUIy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 15:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263181AbTKEUIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 15:08:54 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:12020 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263173AbTKEUIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 15:08:53 -0500
Date: Wed, 05 Nov 2003 11:56:34 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Adam Litke <agl@us.ibm.com>
cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [RFC] Smarter stack traces using the frame pointer
Message-ID: <119200000.1068062194@flay>
In-Reply-To: <20031105132138.59326dd4.sfr@canb.auug.org.au>
References: <1067984031.544.23.camel@agtpad> <20031105132138.59326dd4.sfr@canb.auug.org.au>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I was working on this for the mjb tree but I thought I'd throw it out
>> here in case anyone else finds it interesting.  This simple change to
>> the stack trace code uses the frame pointer to do the trace instead of
>> assuming any kernel address on the stack is a return address.  It makes
>> for much more readable stack traces.
> 
> I was asked by a colleague to do the same thing and came up with this
> alternative version which, I think, gets it mostly right - I am not
> sure about the stack trace from an OOPS.
> 
> Don't bother to tell me this is a bit of a hack - I know :-)
> 
> Patch relative to 2.6.0-test9.

What's the difference between the two patches, apart from the size?
Better error handling / functionality somehow? 

M.

