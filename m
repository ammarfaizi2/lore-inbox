Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbUCQKUm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 05:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbUCQKUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 05:20:41 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:46601 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S261313AbUCQKU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 05:20:27 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.5-rc1-mm1 hangs after Uncompressing kernel...
Date: Wed, 17 Mar 2004 11:18:40 +0100
User-Agent: KMail/1.6.1
Cc: Valdis.Kletnieks@vt.edu, Nick Orlov <bugfixer@list.ru>
References: <20040316175156.GA11785@nikolas.hn.org> <200403162226.i2GMQTGp003101@turing-police.cc.vt.edu>
In-Reply-To: <200403162226.i2GMQTGp003101@turing-police.cc.vt.edu>
X-Operating-System: Linux 2.6.4-wolk2.1 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200403171118.40360@WOLK>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 March 2004 23:26, Valdis.Kletnieks@vt.edu wrote:

Hi Valadis, Nick, Andrew,

> > reverting early-x86-cpu-detection-fix solved the problem for me.
> I had issues with that patch as well, except that rather than a hang, I'd
> get 'Uncompressing kernel...' and then the screen would clear and instead
> of a penguin logo and boot messages, there'd be a second or so of silence
> and then the dread 'ka-chunk' of the machine resetting for a reboot,
> and then I'd be looking at the BIOS screen again.
> Reverting that patch fixed it for me as well.

exactly the same for me.


processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.66GHz
stepping        : 9
cpu MHz         : 3201.176
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 6383.20


ciao, Marc

