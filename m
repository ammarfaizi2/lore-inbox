Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbUBZPyX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 10:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262801AbUBZPyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 10:54:22 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:30732 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261576AbUBZPyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 10:54:21 -0500
Message-ID: <403E1914.5060209@techsource.com>
Date: Thu, 26 Feb 2004 11:04:36 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: "Nakajima, Jun" <jun.nakajima@intel.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Intel vs AMD x86-64
References: <7F740D512C7C1046AB53446D37200173EA288C@scsmsx402.sc.intel.com>
In-Reply-To: <7F740D512C7C1046AB53446D37200173EA288C@scsmsx402.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nakajima, Jun wrote:
> Yes, that's the very reason I said "useless for compilers." The way
> IP/RIP is updated is different (and implementation specific) on those
> processors if 66H is used with a near branch. For example, RIP may be
> zero-extended to 64 bits (from IP), as you observed before.
> 

This is obviously an extremely minor nit-pick, because we're talking 
about one instruction here with an interpretation that is far from 
obvious, but given that there are now only two architectures which 
support x86-64, did Intel choose to do it differently from AMD because 
it was poorly defined, or because it wasn't important enough to want to 
impact the efficiency of the design?

There are people who would go way out of their way to get a 5% 
improvement in performance or decrease in size.  If using 66H with near 
branches could in some way do that, they would really really want to use 
it.  This is why I'm curious.

