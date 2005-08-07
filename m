Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbVHGCZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbVHGCZv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 22:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbVHGCZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 22:25:51 -0400
Received: from terminus.zytor.com ([209.128.68.124]:10447 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750752AbVHGCZu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 22:25:50 -0400
Message-ID: <42F57104.5090208@zytor.com>
Date: Sat, 06 Aug 2005 19:25:08 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Zachary Amsden <zach@vmware.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
       Riley@Williams.Name, pratap@vmware.com, chrisl@vmware.com
Subject: Re: [PATCH 1/8] Move MSR accessors into the sub-arch layer
References: <42F4626D.1000401@vmware.com> <20050807010247.GF7762@shell0.pdx.osdl.net>
In-Reply-To: <20050807010247.GF7762@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Zachary Amsden (zach@vmware.com) wrote:
> 
>>i386 Transparent Paravirtualization Subarch Patch #1
>>
>>This change encapsulates MSR register accessors and moves them into the
>>sub-architecture layer.  The goal is a clean, uniform interface that may
>>be redefined on new sub-architectures of i386.
> 
> I currently have nothing analgous for Xen, but this one looks sane.

I would like to strongly request one addition, however: please make it 
so that a subarchitecture which is still a hardware architecture doesn't 
have to redefine all of these every time.

	-hpa
