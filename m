Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263343AbTKWKaJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 05:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263357AbTKWKaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 05:30:09 -0500
Received: from attila.bofh.it ([213.92.8.2]:461 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S263343AbTKWKaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 05:30:06 -0500
Date: Sun, 23 Nov 2003 11:29:53 +0100
From: "Marco d'Itri" <md@Linux.IT>
To: Andi Kleen <ak@colin2.muc.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: Re: irq 15: nobody cared! with KT600 chipset and 2.6.0-test9
Message-ID: <20031123102953.GA1852@wonderland.linux.it>
References: <m3vfpbiwir.fsf@averell.firstfloor.org> <Pine.LNX.4.44.0311222022120.2379-100000@home.osdl.org> <20031123051011.GA92830@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031123051011.GA92830@colin2.muc.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 23, Andi Kleen <ak@colin2.muc.de> wrote:

 >On Sat, Nov 22, 2003 at 08:23:16PM -0800, Linus Torvalds wrote:
 >> 
 >> On Sun, 23 Nov 2003, Andi Kleen wrote:
 >> > 
 >> > It's a long standing bug in how we handle VIA on board devices in ACPI.
 >> > It was a big problem on x86-64 too until I cheated and used only
 >> > PIC mode when there is a VIA southbridge.
 >> 
 >> That doesn't explain the lack of autodetection, and the early irq15 
 >> registration.
 >> 
 >> That would explain why no interrupts make it at all, but why do we not 
 >> even probe for irq15 here?
 >
 >It's easy to test. does it work when booted with "noapic" ? 
Yes, I checked again.

-- 
ciao, |
Marco | [3232 ma6tjQg3wBT1w]
