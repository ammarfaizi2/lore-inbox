Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315119AbSGYQPD>; Thu, 25 Jul 2002 12:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315266AbSGYQPD>; Thu, 25 Jul 2002 12:15:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23561 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315119AbSGYQO6>; Thu, 25 Jul 2002 12:14:58 -0400
Message-ID: <3D4024A4.5090806@zytor.com>
Date: Thu, 25 Jul 2002 09:17:40 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Brad Hards <bhards@bigpond.net.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Header files and the kernel ABI
References: <aho5ql$9ja$1@cesium.transmeta.com> <200207252308.00656.bhards@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Hards wrote:
> 
> I like it (having just argued for it), except for the __s* and __u*.
> The ABI definitions aren't for kernel programmers. They are for 
> userspace programmers. So we should use standard types,
> even if they are a bit ugly (and uint16_t isn't really much uglier
> than __u16, and at least it doesn't carry connotations of
> something that is meant to be internal, which is what the standard
> double-underscore convention means). 
> 

Not quite -- it means they are implementation-specific (in this case, 
Linux-specific.)  The Linux __s* and __u* predates <stdint.h>; I 
certainly would like to migrate to <stdint.h> but I don't see it as a 
very high priority.

	-hpa


