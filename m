Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263597AbREYHA3>; Fri, 25 May 2001 03:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263599AbREYHAT>; Fri, 25 May 2001 03:00:19 -0400
Received: from sgi.SGI.COM ([192.48.153.1]:33405 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S263597AbREYHAE>;
	Fri, 25 May 2001 03:00:04 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: esr@thyrsus.com
cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: Configure.help entries wanted 
In-Reply-To: Your message of "Fri, 25 May 2001 02:35:58 -0400."
             <20010525023558.B5622@thyrsus.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 25 May 2001 16:59:24 +1000
Message-ID: <24758.990773964@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2001 02:35:58 -0400, 
"Eric S. Raymond" <esr@thyrsus.com> wrote:
>Keith Owens <kaos@ocs.com.au>:
>> +McKinley A-step specific code
>> +CONFIG_MCKINLEY_ASTEP_SPECIFIC
>> +  Select this option to build a kernel for an IA64 McKinley system
>> +  with any A-stepping CPU.
>> +
>> +McKinley A0/A1-step specific code
>> +CONFIG_MCKINLEY_A0_SPECIFIC
>> +  Select this option to build a kernel for an IA64 McKinley system
>> +  with an A0 or A1 stepping CPU.
>
>Is there a value range in /proc/cpuinfo that tells you you have an A/A0 step?

Unfortunately I do not have the McKinley data yet, the NDA is worse
than the Itanium one.  Fill in later when the data is available, I
expect more McKinley steppings to be added to the list.

>> +CONFIG_IA64_DEBUG_CMPXCHG
>> +  Selecting this option turns on bug checking for the IA64
>> +  compare-and-exchange instructions.  This is slow!  If you're unsure,
>> +  select N.
>
>These would be much improved by some indication of what IA64 variants or mask
>steppings have these problems.

Early ones for compare-and-exchange.  AFAIK no recent (Itanium B3 or
later) cpu has these problems.

>> +IA64 IRQ bug checking
>> +CONFIG_IA64_DEBUG_IRQ
>> +  Selecting this option turns on bug checking for the IA64 irq_save and
>> +  restore instructions.  This is slow!  If you're unsure, select N.

This is software, not hardware, debugging.  It saves addresses to help
track down spinlock problems.

