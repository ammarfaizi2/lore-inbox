Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316532AbSFEXNL>; Wed, 5 Jun 2002 19:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316535AbSFEXNK>; Wed, 5 Jun 2002 19:13:10 -0400
Received: from mta06bw.bigpond.com ([139.134.6.96]:56316 "EHLO
	mta06bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S316532AbSFEXNK>; Wed, 5 Jun 2002 19:13:10 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Dave Jones <davej@suse.de>
Subject: Re: [patch] i386 "General Options" - begone [take 2]
Date: Thu, 6 Jun 2002 09:11:20 +1000
User-Agent: KMail/1.4.5
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        trivial@rustcorp.com.au
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7ED5@orsmsx111.jf.intel.com> <200206051134.24063.bhards@bigpond.net.au> <20020605122939.H5277@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206060911.20027.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2002 20:29, Dave Jones wrote:
> On Wed, Jun 05, 2002 at 11:34:23AM +1000, Brad Hards wrote:
>  > One idea that comes to mind is putting the power management config
>  > options in a "Power Management" section
>
> *nod* sounds sensible 8)
>
>  > then PNPBIOS in with the other PnP stuff, and
>  > so on (read: don't know were to put MPS yet, and don't know what $PIR is
>  > :)
>
> It's an interrupt routing table.
>
> MPS and interrupt routing are both CPU related features, so the best
> place we currently have is under the CPU menu imho.
Is it fundamentally different _functionality_ to the stuff that is in "Plug 
and Play configuration" (which makes devices automatically get the right 
itnerrupts)?  [ Ignore implementation for a second - we can always solve this 
with another layer of abstraction. :-]

Of course, putting all this into the CPU menu (which is obviously a per-arch 
config.in change) would make drivers/arch/acpi/Config.in look a lot cleaner.

I'll try to work with Andy Grover off-list with this, and come up with an 
agreed position.

Rusty: This is starting to get a little non-trivial. Please drop the two 
patches I've sent. I'll get back to you later.

Brad
-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
