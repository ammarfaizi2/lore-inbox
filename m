Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbUAHDyt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 22:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbUAHDyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 22:54:49 -0500
Received: from terminus.zytor.com ([63.209.29.3]:65449 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263632AbUAHDys
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 22:54:48 -0500
Message-ID: <3FFCD47F.1010007@zytor.com>
Date: Wed, 07 Jan 2004 19:54:39 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Use of floating point in the kernel
References: <20040107235912.GA23812@ee.oulu.fi> <3FFCCFAE.8090302@zytor.com> <Pine.LNX.4.58.0401071948470.2131@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0401071948470.2131@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> We really should, but there really are some rare cases where it is 
> actually ok.
> 
> In particular, you _can_ do math, if you just do the proper
> "kernel_fpu_begin()"/"kernel_fpu_end()" around it, and you have reason to 
> believe that you can assume a math processor exists. 
> 
> Is it needed? I dunno. I'd frown on it in general, but I don't see it 
> being fundamentally wrong under the rigth circumstances.
> 

Sure; however, perhaps those can be marked separately in the Makefile.

	-hpa

