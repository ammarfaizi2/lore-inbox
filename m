Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752119AbWCJCdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbWCJCdL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 21:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752121AbWCJCdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 21:33:11 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:31896 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1752119AbWCJCdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 21:33:09 -0500
Date: Thu, 09 Mar 2006 20:32:43 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: How can I link the kernel with libgcc ?
In-reply-to: <5OEVB-3GX-15@gated-at.bofh.it>
To: Carlos Munoz <carlos@kenati.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4410E54B.6020400@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5OEVB-3GX-15@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Munoz wrote:
> Hi all,
> 
> I'm writing an audio driver and the hardware requires floating point 
> arithmetic.  When I build the kernel I get the following errors at link 
> time:

Floating point + kernel = no no. If the hardware requires floating point 
manipulations this should go in userspace.

> These symbols are coming from gcc. What I would like to do is link the 
> kernel with libgcc to solve this errors. I'm looking at the kernel 
> makefiles and it doesn't seem obvious to me how to do it. Does anyone 
> know how I can link the kernel with libgcc, or point me in the right 
> direction ?

This is almost certainly a bad idea. The functions inside libgcc are not 
designed to run inside a kernel.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

