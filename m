Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314548AbSFTOuk>; Thu, 20 Jun 2002 10:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314748AbSFTOuk>; Thu, 20 Jun 2002 10:50:40 -0400
Received: from twin.jikos.cz ([217.11.236.59]:58014 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id <S314548AbSFTOui>;
	Thu, 20 Jun 2002 10:50:38 -0400
Date: Thu, 20 Jun 2002 16:50:26 +0200 (CEST)
From: Jirka Kosina <jikos@jikos.cz>
To: Brian Gerst <bgerst@didntduck.org>
cc: devnull@adc.idt.com, <linux-kernel@vger.kernel.org>
Subject: Re: >3G Memory support
In-Reply-To: <3D11E9ED.7060101@didntduck.org>
Message-ID: <Pine.LNX.4.44.0206201647090.22725-100000@twin.jikos.cz>
References: <Pine.GSO.4.31.0206201010340.13158-100000@bom.adc.idt.com>
 <3D11E9ED.7060101@didntduck.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2002, Brian Gerst wrote:

> > What limits user space to 3GB.
> Hardware limitations imposed by the x86 architecture.  The x86 only has 
> _one_ virtual address space, which has to be shared by user space and 
> kernel space.  It is not possible to give user space more virtual 
> address space without taking it away from the kernel.

You can theoretically run kernel in one task (I mean "task" in the 
Intel-processor-meaning of the word ;) ) and userspace programs in another 
task, which will result in having 4GB of memory for both of them, won't 
it?

I know, there would be big compilcations - for example copying data 
betweeen userspace and kernelspace should be problem, and if implemented, 
I can't imagine how to do it considerably fast...which is IMHO the main 
reason why it isn't done such way.

-- 
JiKos.


