Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262898AbTDAW4l>; Tue, 1 Apr 2003 17:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262903AbTDAW4l>; Tue, 1 Apr 2003 17:56:41 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:51221 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id <S262898AbTDAW4k>; Tue, 1 Apr 2003 17:56:40 -0500
From: Jos Hulzink <josh@stack.nl>
To: Matthew Harrell 
	<mharrell-dated-1049658915.d5a407@bittwiddlers.com>,
       Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 529] New: ACPI under 2.5.50+ (approx) locks system hard during bootup
Date: Wed, 2 Apr 2003 01:07:58 +0200
User-Agent: KMail/1.5
Cc: chris@wirex.com, andrew.grover@intel.com
References: <130680000.1049224849@flay> <20030401114749.A7647@figure1.int.wirex.com> <20030401195514.GA29214@bittwiddlers.com>
In-Reply-To: <20030401195514.GA29214@bittwiddlers.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304020107.58676.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 April 2003 21:55, Matthew Harrell wrote:
> I've tried every kernel I could get to build up through 2.5.66 and nothing
> changed.  Same behavior every time
>
> Also, I can get them all to boot into single user mode.  I'm going to check
> if the hang is caused by the loading of the alsa modules (which run on the
> same interrupt) or something else.

The only way I can boot recent 2.5 kernels is to make sure my BIOS does 
nothing that even smells like ACPI. The only response I got so far on the 
lkml is "disable acpi support" and "disable apic support". The only 
conclusion I can make is that the ACPI support in 2.5 is buggy enough to 
prevent 2.5 to emerge into 2.6 for a long time from now, and unfortunately 
nobody seems to care. I detected big IRQ / ACPI / APIC trouble since about  
2.5.44 - 2.5.53, and nothing has changed since. 

NFI, I just don't understand that a core problem that prevents me from booting 
2.5 kernels, is noticed by so few others that it is able to remain unfixed 
for so long.

Jos
