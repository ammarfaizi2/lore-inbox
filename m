Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282097AbRK1JLz>; Wed, 28 Nov 2001 04:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282095AbRK1JLr>; Wed, 28 Nov 2001 04:11:47 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:48632 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S282081AbRK1JLm>; Wed, 28 Nov 2001 04:11:42 -0500
Date: Wed, 28 Nov 2001 01:04:11 -0800
From: Chris Wright <chris@wirex.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] tree-based bootmem
Message-ID: <20011128010411.A14584@figure1.int.wirex.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011117011415.B1180@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011117011415.B1180@holomorphy.com>; from wli@holomorphy.com on Sat, Nov 17, 2001 at 01:14:15AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* William Lee Irwin III (wli@holomorphy.com) wrote:
> Critiques, testing results, and any commentary whatsoever are quite welcome.

test results from 32-bit SPARC (sun4m).

2.5.1-pre1+show_trace_task (patch form DaveM)

ftp://ftp.kernel.org/pub/linux/kernel/people/wli/bootmem/bootmem-2.5.1-pre1

applied cleanly, compiled fine, but didn't boot.

boot: 2.5.1-pre1-bootmem
Uncompressing image...
Loading initial ramdisk....
PROMLIB: obio_ranges 5
Fixup b f01e9720 doesn't refer to a SETHI at f0119e34[7fffc344]
Program terminated
Type  help  for more information
<#0> ok         

so, where to go from here?  btw, i did verify that a non bootmem patched
2.5.1-pre1-show_tace_task kernel booted.

# uname -a
Linux c.sous.sol 2.5.1-pre1 #8 SMP Wed Nov 28 08:55:49 PST 2001 sparc unknown

cheers,
-chris
