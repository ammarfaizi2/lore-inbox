Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263759AbTFBQQu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 12:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTFBQQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 12:16:50 -0400
Received: from lvs00-fl.valueweb.net ([216.219.253.199]:10455 "EHLO
	ams013.ftl.affinity.com") by vger.kernel.org with ESMTP
	id S263620AbTFBQQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 12:16:48 -0400
Message-ID: <3EDB7B83.1020108@coyotegulch.com>
Date: Mon, 02 Jun 2003 12:29:55 -0400
From: Scott Robert Ladd <coyote@coyotegulch.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Dresser <mdresser_l@windsormachine.com>
CC: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
Subject: Re: Hyper-threading
References: <Pine.LNX.4.33.0306021147460.31561-100000@router.windsormachine.com>
In-Reply-To: <Pine.LNX.4.33.0306021147460.31561-100000@router.windsormachine.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Dresser wrote:
> Indeed, I saw that.  On the P4 2.66ghz that you have, the "second" cpu is
> disabled by intel, as they sell hyperthreading only on the newer Xeon P4
> (which you don't have), and the new 800FSB (4x200) units, which again
> you don't have.
> 
> ..... CPU clock speed is 2672.7802 MHz.
> ..... host bus clock speed is 133.6388 MHz.

Some Pentium 4 chips support HT even when they officially "don't". For 
example, my system has an Intel MB and a Pentium 4 2.8GHz processor; it 
boots using HT just fine. From a recent boot:

Tycho kernel: CPU1: Intel Pentium 4 (Northwood) stepping 07
Tycho kernel: Total of 2 processors activated (11042.81 BogoMIPS).
Tycho kernel: cpu_sibling_map[0] = 1
Tycho kernel: cpu_sibling_map[1] = 0
Tycho kernel: ENABLING IO-APIC IRQs
Tycho kernel: Setting 2 in the phys_id_present_map
Tycho kernel: ...changing IO-APIC physical APIC ID to 2 ... ok.
Tycho kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Tycho kernel: testing the IO APIC.......................
Tycho kernel: .................................... done.
Tycho kernel: Using local APIC timer interrupts.
Tycho kernel: calibrating APIC timer ...
Tycho kernel: ..... CPU clock speed is 2783.0819 MHz.
Tycho kernel: ..... host bus clock speed is 132.0562 MHz.
Tycho kernel: checking TSC synchronization across 2 CPUs: passed.
Tycho kernel: Starting migration thread for cpu 0
Tycho kernel: Bringing up 1
Tycho kernel: CPU 1 IS NOW UP!
Tycho kernel: Starting migration thread for cpu 1
Tycho kernel: CPUS done 2

Note the "132.0562" MHz bus speed.

I obtained my system directly from Intel; however, I know of a few 
people who obtained Pentium 4 chips from retailers, and their processors 
support HT with a 4x133 bus.

-- 
Scott Robert Ladd
Coyote Gulch Productions (http://www.coyotegulch.com)
Professional programming for science and engineering;
Interesting and unusual bits of very free code.

