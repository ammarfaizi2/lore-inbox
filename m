Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbVHaWR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbVHaWR7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 18:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbVHaWR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 18:17:59 -0400
Received: from terminus.zytor.com ([209.128.68.124]:44765 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964932AbVHaWR6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 18:17:58 -0400
Message-ID: <43162C7C.8040202@zytor.com>
Date: Wed, 31 Aug 2005 15:17:32 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Jesper Juhl <jesper.juhl@gmail.com>, Alon Bar-Lev <alon.barlev@gmail.com>,
       Andrew Morton <akpm@osdl.org>, SYSLINUX@zytor.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
References: <4315B668.6030603@gmail.com> <43162148.9040604@zytor.com> <20050831215757.GA10804@taniwha.stupidest.org> <431628D5.1040709@zytor.com> <20050831220717.GA14625@taniwha.stupidest.org> <9a874849050831151230d68d64@mail.gmail.com> <20050831221424.GA14806@taniwha.stupidest.org>
In-Reply-To: <20050831221424.GA14806@taniwha.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Thu, Sep 01, 2005 at 12:12:00AM +0200, Jesper Juhl wrote:
> 
>>b) add a new boot option telling the kernel the name of some file in
>>initrd or similar from which to load additional options.
> 
> a file in initrd isn't a good choice; as the initrd is generally a fix
> image
> 
> the point is some bootloaders might want to pass quite a bit of state
> to the kernel at times (i actually have this for a mip32 target where
> i construct a table and pass a pointer to that in, a tad icky but for
> lack of options)

initrd is a fixed image, but initramfs can be synthesized.

	-hpa
