Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264233AbUANT2r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 14:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264258AbUANT2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 14:28:31 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:57300 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264233AbUANTZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 14:25:29 -0500
Date: Wed, 14 Jan 2004 20:25:06 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andi Kleen <ak@colin2.muc.de>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: [PATCH] Add CONFIG for -mregparm=3
Message-ID: <20040114192505.GJ23383@fs.tum.de>
References: <20040114090603.GA1935@averell> <20040114012928.1e90af3b.akpm@osdl.org> <20040114093556.GB19652@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114093556.GB19652@colin2.muc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 10:35:56AM +0100, Andi Kleen wrote:
>...
> I think the popular modules like nvidia or ATI could be fixed 
> relatively easily.  They usually consist of a glue layer with source and a 
> binary blob that is only called from the glue layer. Basically all you 
> have to do is the mark the prototypes for the binary blob in the glue layer
> as "asmlinkage". In addition this can be done without any ifdefs
> because asmlinkage does the right thing on a non regparm kernel.
> 
> Of course true binary only modules without glue layer would be more
> difficult, but for those the vendors just have to recompile. Conceivable
> it would be possible to write a glue layer even for them.
>...

Did I miss Linus announcing a stable ABI between kernel versions?

If some binary module vendor tries to support more than one kernel
version it's his problem - this is nothing that is officially supported
by the Linux kernel.

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

