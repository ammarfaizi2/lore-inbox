Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318293AbSG3OLF>; Tue, 30 Jul 2002 10:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318296AbSG3OLF>; Tue, 30 Jul 2002 10:11:05 -0400
Received: from ns.suse.de ([213.95.15.193]:2575 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318293AbSG3OLE>;
	Tue, 30 Jul 2002 10:11:04 -0400
Date: Tue, 30 Jul 2002 16:13:45 +0200
From: Andi Kleen <ak@suse.de>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eepro 0.13a
Message-ID: <20020730161345.A3998@wotan.suse.de>
References: <20020730125601.GT16077@cathedrallabs.org.suse.lists.linux.kernel> <p73sn21s5ij.fsf@oldwotan.suse.de> <20020730134825.GU16077@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020730134825.GU16077@cathedrallabs.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> printk that doesn't start a new line had KERN_* removed because it prints in
> the middle of line KERN_* macros like
>  id: 0xb4 <7> io: 0x340 <6>eth0: Intel EtherExpress Pro/10+ ISA
> i had the same reaction but Michael pointed this to me. i don't know exactly
> how this macro works, but you'll have the line printed out with the

The macro just prepends a sting using ISO C string concatenation.
> beggining using KERN_* macro. isn't that sufficient?

That makes sense. Thanks,

-Andi
