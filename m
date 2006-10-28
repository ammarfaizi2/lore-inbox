Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbWJ1Uuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWJ1Uuh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 16:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWJ1Uuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 16:50:37 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:396 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751413AbWJ1Uuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 16:50:37 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4543C22A.2060203@s5r6.in-berlin.de>
Date: Sat, 28 Oct 2006 22:48:42 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Grant Grundler <grundler@parisc-linux.org>
CC: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Matthew Wilcox <matthew@wil.cx>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [patch] drivers: wait for threaded probes between initcall levels
References: <20061026191131.003f141d@localhost.localdomain> <20061027170748.GA9020@kroah.com> <20061027172219.GC30416@elf.ucw.cz> <20061027113908.4a82c28a.akpm@osdl.org> <20061027114144.f8a5addc.akpm@osdl.org> <20061027114237.d577c153.akpm@osdl.org> <1161989970.16839.45.camel@localhost.localdomain> <20061027160626.8ac4a910.akpm@osdl.org> <20061028050905.GB5560@colo.lackof.org> <20061027221925.1041cc5e.akpm@osdl.org> <20061028060833.GC5560@colo.lackof.org>
In-Reply-To: <20061028060833.GC5560@colo.lackof.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler wrote:
> On Fri, Oct 27, 2006 at 10:19:25PM -0700, Andrew Morton wrote:
>>> I thought parallel PCI and SCSI probing on system with multiple NICs and
>>> "SCSI" storage requires udev to create devices with consistent naming.
>> For some reason people get upset when we rename all their devices.  They're
>> a humourless lot.
> 
> Hey! I resemble that remark! ;)
> 
> (yeah, I've been a victim of that problem way too many times.)

I hear network interfaces can be selected by their MACs, which are
globally unique and persistent. Most SCSI hardware has globally unique
and persistent unit properties too, and udev indeed uses them these days.
-- 
Stefan Richter
-=====-=-==- =-=- ===--
http://arcgraph.de/sr/
