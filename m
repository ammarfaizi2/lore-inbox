Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbTFCMpv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 08:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264987AbTFCMpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 08:45:51 -0400
Received: from garnet.acns.fsu.edu ([146.201.2.25]:14579 "EHLO
	garnet.acns.fsu.edu") by vger.kernel.org with ESMTP id S264984AbTFCMpt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 08:45:49 -0400
Message-ID: <3EDC9B6B.3000809@cox.net>
Date: Tue, 03 Jun 2003 08:58:19 -0400
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Margit Schubert-While <margitsw@t-online.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21rc6-ac2
References: <5.1.0.14.2.20030603143135.00ae9d40@pop.t-online.de>
In-Reply-To: <5.1.0.14.2.20030603143135.00ae9d40@pop.t-online.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Margit Schubert-While wrote:
> Alan, a few things that I think should be in (and for the next rc ?) -
> 1) Force inline for >= gcc 3.3
> 2) -march=  for pentium3/4
> 3) Radeon 9k support
> 4) Junk the chipset id'ing in agp_support.h
>      (Not in DRI/DRM mainline and not in 2.5)
> Margit

I agree on the march support. I've been using my own trivial patch for 
the i386 Makefile to have direct support for the P3 and P4. Just trying 
to figure out whether adding sse2 support on the compile line will 
create problems. GCC does not use SSE(2) unless you explicitly tell it to.

-David

