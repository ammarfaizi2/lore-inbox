Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266489AbUBRQr7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 11:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266494AbUBRQr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 11:47:59 -0500
Received: from terminus.zytor.com ([63.209.29.3]:1157 "EHLO terminus.zytor.com")
	by vger.kernel.org with ESMTP id S266489AbUBRQru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 11:47:50 -0500
Message-ID: <40339723.9060406@zytor.com>
Date: Wed, 18 Feb 2004 08:47:31 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402161948.i1GJmJi5000299@81-2-122-30.bradfords.org.uk> <Pine.LNX.4.58.0402161141140.30742@home.osdl.org> <20040216202142.GA5834@outpost.ds9a.nl> <c0ukd2$3uk$1@terminus.zytor.com> <Pine.LNX.4.58.0402171910550.2686@home.osdl.org> <20040218113338.GH28599@mail.shareable.org>
In-Reply-To: <20040218113338.GH28599@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> 
> hpa's suggestion that invalid bytes are treated as 0x800000xx works
> very nicely, *iff* a program is absolutely consistent about its
> treatment of bytes in that way.  When there's a mixture of code which
> interprets malformed UTF-8 in different ways, then it's messy and
> sometimes a security hazard.
> 

Absolutely.  It has to be considered very carefully.

	-hpa
