Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283019AbRK1Mks>; Wed, 28 Nov 2001 07:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283022AbRK1Mkj>; Wed, 28 Nov 2001 07:40:39 -0500
Received: from holomorphy.com ([216.36.33.161]:47537 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S282138AbRK1MkX>;
	Wed, 28 Nov 2001 07:40:23 -0500
Date: Wed, 28 Nov 2001 04:40:01 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] tree-based bootmem
Message-ID: <20011128044001.C3921@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011117011415.B1180@holomorphy.com> <20011128010411.A14584@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20011128010411.A14584@figure1.int.wirex.com>; from chris@wirex.com on Wed, Nov 28, 2001 at 01:04:11AM -0800
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2001 at 01:04:11AM -0800, Chris Wright wrote:
> test results from 32-bit SPARC (sun4m).
> 2.5.1-pre1+show_trace_task (patch form DaveM)
> ftp://ftp.kernel.org/pub/linux/kernel/people/wli/bootmem/bootmem-2.5.1-pre1
> applied cleanly, compiled fine, but didn't boot.


Thanks for tracking this down. Now I must find a machine to debug on...


On Wed, Nov 28, 2001 at 01:04:11AM -0800, Chris Wright wrote:
> boot: 2.5.1-pre1-bootmem
> Uncompressing image...
> Loading initial ramdisk....
> PROMLIB: obio_ranges 5
> Fixup b f01e9720 doesn't refer to a SETHI at f0119e34[7fffc344]
> Program terminated
> Type  help  for more information
> <#0> ok         


I'd be interested in finding out what this error means. Can anyone
comment on this?


On Wed, Nov 28, 2001 at 01:04:11AM -0800, Chris Wright wrote:
> so, where to go from here?  btw, i did verify that a non bootmem patched
> 2.5.1-pre1-show_tace_task kernel booted.
> # uname -a
> Linux c.sous.sol 2.5.1-pre1 #8 SMP Wed Nov 28 08:55:49 PST 2001 sparc unknown


I'm going to have to find a machine similar or identical to yours where
I can reproduce the error and debug. Any assistance toward this end is
much appreciated.


Thanks,
Bill
