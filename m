Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275083AbTHRVMH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 17:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275097AbTHRVMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 17:12:07 -0400
Received: from hal-4.inet.it ([213.92.5.23]:31486 "EHLO hal-4.inet.it")
	by vger.kernel.org with ESMTP id S275083AbTHRVL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 17:11:59 -0400
From: Paolo Ornati <javaman@katamail.com>
To: herbert@13thfloor.at
Subject: Re: [OT] Documentation for PC Architecture
Date: Mon, 18 Aug 2003 23:11:53 +0200
User-Agent: KMail/1.5.2
References: <200308181127.43093.javaman@katamail.com> <20030818185507.GB8297@www.13thfloor.at>
In-Reply-To: <20030818185507.GB8297@www.13thfloor.at>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308182244.01727.javaman@katamail.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> > Curiosity: since the memory addresses from 640KB to 1MB are reserved for
> > memory mapped I/O (video memory) and BIOS ROM... the corrispondent range
> > in
>
> uh oh ...
>
> > the REAL MEMORY isn't usable and so we lost 384KB of memory. Is this
> > right?
>
> for DOS, withouth upper memory manager yes ;)

I'm talking about an OS in protected mode... in any case how can I access to 
this memory region if it's mapped for other things?

I've done some tests with a simple kernel which I wrote: all that region 
(except video memory at 0xb8000) results "read only"...

So I THINK YOU mean: "you can use more than 640KB in real mode using a memory 
manager that "remap" 0xC0000 (for example) to 0x100000 or something like it"

Right?

bye,
	Paolo

