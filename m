Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbVHaWCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbVHaWCS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 18:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbVHaWCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 18:02:18 -0400
Received: from terminus.zytor.com ([209.128.68.124]:36056 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932529AbVHaWCR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 18:02:17 -0400
Message-ID: <431628D5.1040709@zytor.com>
Date: Wed, 31 Aug 2005 15:01:57 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Alon Bar-Lev <alon.barlev@gmail.com>, Andrew Morton <akpm@osdl.org>,
       SYSLINUX@zytor.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
References: <4315B668.6030603@gmail.com> <43162148.9040604@zytor.com> <20050831215757.GA10804@taniwha.stupidest.org>
In-Reply-To: <20050831215757.GA10804@taniwha.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Wed, Aug 31, 2005 at 02:29:44PM -0700, H. Peter Anvin wrote:
> 
>>I think someone on the SYSLINUX mailing list already sent a patch to
>>akpm to make 512 the default; making it configurable would be a
>>better idea.  Feel free to send your patch through me.
> 
> So we really need this to be a configuration option?  We have too many
> of those already.

Maybe not.  Another option would simply be to bump it up significantly 
(2x isn't really that much.)   4096, maybe.

	-hpa
