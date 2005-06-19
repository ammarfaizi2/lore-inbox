Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVFSA5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVFSA5N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 20:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262212AbVFSA5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 20:57:13 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:30916 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S261473AbVFSA5I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 20:57:08 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Andi Kleen <ak@muc.de>
Subject: Re: [2.6.12] x86-64 IO-APIC + timer doesn't work
Date: Sun, 19 Jun 2005 01:57:28 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, ACurrid@nvidia.com
References: <200506181452.52921.s0348365@sms.ed.ac.uk> <20050618190921.GA59126@muc.de> <200506190121.13253.s0348365@sms.ed.ac.uk>
In-Reply-To: <200506190121.13253.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506190157.28997.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 Jun 2005 01:21, Alistair John Strachan wrote:
[snip]
>
> Here's a copy of my dmesg from a boot with apic=verbose. I see warnings
> about a buggy NMI and a broken timer pin, but I think I've always had those
> problems. (BTW, I've switched mailer recently and I haven't figured out how
> to do inline attachments, I apologise for the encoded one.)

Despite the fact that this wasn't documented in the BIOS update, an update for 
my board (MS-7030 Neo Platinum by MSI) supposedly fixing "Fan Function" 
actually corrects the IO-APIC and NMI bugs. I now get the following in dmesg 
instead:

Calibrating delay loop... 3973.12 BogoMIPS (lpj=1986560)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3000+ stepping 00
Using local APIC timer interrupts.
Detected 12.561 MHz APIC timer.
testing NMI watchdog ... OK.

So I'm a happy man. Whether this is at all related to the problems I was 
having before, I don't really know. If the problem doesn't reoccur, I could 
very well have wasted your time.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
