Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWH2DTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWH2DTj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 23:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWH2DTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 23:19:39 -0400
Received: from main.gmane.org ([80.91.229.2]:32719 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932135AbWH2DTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 23:19:38 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
Date: Tue, 29 Aug 2006 06:19:28 +0200
Organization: Palacky University in Olomouc, experimental physics dep.
Message-ID: <44F3C050.4030002@flower.upol.cz>
References: <1156802900.3465.30.camel@mulgrave.il.steeleye.com> <1156803102.3465.34.camel@mulgrave.il.steeleye.com> <20060828230452.GA4393@powerlinux.fr> <44F38BCE.2080108@flower.upol.cz> <1156809344.3465.41.camel@mulgrave.il.steeleye.com> <44F3A355.6090408@flower.upol.cz> <20060829015103.GA28162@kroah.com> <20060829031430.GA9820@flower.upol.cz> <20060829024901.GA32426@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 158.194.192.153
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20060607 Debian/1.7.12-1.2
X-Accept-Language: en
In-Reply-To: <20060829024901.GA32426@kroah.com>
Cc: debian-kernel@lists.debian.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Aug 29, 2006 at 05:14:30AM +0200, Oleg Verych wrote:
> 
>>On Mon, Aug 28, 2006 at 06:51:03PM -0700, Greg KH wrote:
>>
>>>On Tue, Aug 29, 2006 at 04:15:49AM +0200, Oleg Verych wrote:
>>>
>>>>>>request_firmware() is dead also.
>>>>>>YMMV, but three years, and there are still big chunks of binary in kernel.
>>>>>>And please don't add new useless info _in_ it.
>>>>
>>>>Hell, what can be as easy as this:
>>>>,-
>>>>|modprobe $drv
>>>>|(dd </lib/firmware/$drv.bin>/dev/blobs && echo OK) || echo Error
>>>>`-
>>>>where /dev/blobs is similar to /dev/port or even /dev/null char device.
>>>>if synchronization is needed, add `echo $drv >/dev/blobs`, remove modprobe,
>>>
...
> 
>>I'm nether a CS nor software engineer, just wondering why simple thing isn't
>>simple _in_ the Kernel. I'm reading list "just for fun (C)" and any good word
>>about this (IMHO) unix-way design *may* lead professional programmers to do
>>tiny worthy things (think about kevent discussion).
>>If it's (i'm) stupid, please, say so (in the way Nicholas Miell did ;).
> 
> I don't think it's workable, and goes against the current way the kernel
> does things.  But please, feel free to prove me wrong with a patch
> otherwise.  I don't want to debate it otherwise.
> 
Thanks, and OK, this is my last reply on this.

> I think the current way we handle firmware works quite well, especially
> given the wide range of different devices that it works for (everything
> from BIOS upgrades to different wireless driver stages).
> 
Oh, come on, even skilled developers (not particular kernel's) having
difficulties with current hotplug-sysfs-modprobe thing;
in this case one couldn't easily figure out problems and way to solve them
<http://permalink.gmane.org/gmane.comp.hardware.texas-instruments.msp430.gcc.user/5444>

Goodbye.

--
-o--=O`C  /. .\   (+)
  #oo'L O      o    |
<___=E M    ^--    |  (you're barking up the wrong tree)

