Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315162AbSFTP1t>; Thu, 20 Jun 2002 11:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312498AbSFTP1s>; Thu, 20 Jun 2002 11:27:48 -0400
Received: from holomorphy.com ([66.224.33.161]:50110 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315162AbSFTP1r>;
	Thu, 20 Jun 2002 11:27:47 -0400
Date: Thu, 20 Jun 2002 08:27:00 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jirka Kosina <jikos@jikos.cz>
Cc: Brian Gerst <bgerst@didntduck.org>, devnull@adc.idt.com,
       linux-kernel@vger.kernel.org
Subject: Re: >3G Memory support
Message-ID: <20020620152700.GU22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jirka Kosina <jikos@jikos.cz>, Brian Gerst <bgerst@didntduck.org>,
	devnull@adc.idt.com, linux-kernel@vger.kernel.org
References: <Pine.GSO.4.31.0206201010340.13158-100000@bom.adc.idt.com> <3D11E9ED.7060101@didntduck.org> <Pine.LNX.4.44.0206201647090.22725-100000@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0206201647090.22725-100000@twin.jikos.cz>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2002, Brian Gerst wrote:
>> Hardware limitations imposed by the x86 architecture.  The x86 only has 
>> _one_ virtual address space, which has to be shared by user space and 
>> kernel space.  It is not possible to give user space more virtual 
>> address space without taking it away from the kernel.

On Thu, Jun 20, 2002 at 04:50:26PM +0200, Jirka Kosina wrote:
> You can theoretically run kernel in one task (I mean "task" in the 
> Intel-processor-meaning of the word ;) ) and userspace programs in another 
> task, which will result in having 4GB of memory for both of them, won't 
> it?

This is what BIGMEM did. It predated the current highmem implementation.


Cheers,
Bill
