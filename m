Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273859AbRIXLDB>; Mon, 24 Sep 2001 07:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273857AbRIXLCw>; Mon, 24 Sep 2001 07:02:52 -0400
Received: from ns.hobby.nl ([212.72.224.8]:1810 "EHLO hgatenl.hobby.nl")
	by vger.kernel.org with ESMTP id <S273858AbRIXLCk>;
	Mon, 24 Sep 2001 07:02:40 -0400
Date: Mon, 24 Sep 2001 12:52:55 +0200
From: toon@vdpas.hobby.nl
To: linux-kernel@vger.kernel.org
Subject: Re: /proc/partitions hosed
Message-ID: <20010924125255.B4755@vdpas.hobby.nl>
In-Reply-To: <20010924124131.A4755@vdpas.hobby.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010924124131.A4755@vdpas.hobby.nl>; from toon@vdpas.hobby.nl on Mon, Sep 24, 2001 at 12:41:31PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2001 at 12:41:31PM +0200, toon@vdpas.hobby.nl wrote:
> Hi,
> 
> [...]
> 
> For convenience I'll give you the output of some relevant commands:

Of course, I forgot some extremely relevant information:

# uname -a
Linux vdpas.hobby.nl 2.4.10 #1 SMP Mon Sep 24 00:39:55 CEST 2001 i686 unknown

# cat /proc/cpuinfo 
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 7
model name	: Pentium III (Katmai)
stepping	: 2
cpu MHz		: 451.033
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 897.84

So this an SMP kernel, running on a single processor machine.

Regards,
Toon.
-- 
 /"\                             |   Windows XP:
 \ /     ASCII RIBBON CAMPAIGN   |        "I'm sorry Dave...
  X        AGAINST HTML MAIL     |         I'm afraid I can't do that."
 / \
