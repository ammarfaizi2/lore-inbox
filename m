Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266148AbTLIIiW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 03:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266149AbTLIIiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 03:38:22 -0500
Received: from main.gmane.org ([80.91.224.249]:39640 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266144AbTLIIf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 03:35:56 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Holger Schurig <h.schurig@mn-logistik.de>
Subject: Re: State of devfs in 2.6?
Date: Tue, 09 Dec 2003 09:21:56 +0100
Message-ID: <br41h9$mth$1@sea.gmane.org>
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com> <pan.2003.12.08.23.04.07.111640@dungeon.inka.de> <20031208233428.GA31370@kroah.com> <1070953338.7668.6.camel@simulacron> <20031209071303.GB24876@Master.launchmodem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> how many bug reports did you see in the last three months of people
>> having problems with devfs? I don't doubt the problems in theory, but
>> but I simply haven't seen them happening. Most users seem quite happy.
>> 
> 
> Actually, I think most users who have problems just disable devfs. Most of
> the people I know have done that. No point in making bug reports about
> something that is unmaintained and deprecated.

No, not really.

Devfs for embedded devices is just great. It's all in the kernel, no
external process to run (I use my embedded stuff without devfsd). I'm using
it for about one year with various kernels.

For me, I see several benefits:

* space. devfs doesn't eat space like the MAKEDEV approach.
* simplicity: I run my system without devfsd and without an initial ramdisk.
All needed modules are simply compiled into the kernel.
* No need for overcomplification, e.g a process that has to be started
before userspace touches /dev, a specially compiled uclibc-based proggy in
an initrd

So, when /dev is accessed by userspace, all is there and well.

-- 
Try Linux 2.6 from BitKeeper for PXA2x0 CPUs at
http://www.mn-logistik.de/unsupported/linux-2.6/

