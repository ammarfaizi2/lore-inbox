Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263805AbUBODYX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 22:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbUBODYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 22:24:23 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:25039
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S263805AbUBODYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 22:24:21 -0500
Message-ID: <402EE1EE.10806@tmr.com>
Date: Sat, 14 Feb 2004 22:05:18 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ricky Beam <jfbeam@bluetronic.net>
CC: Dave Kleikamp <shaggy@austin.ibm.com>,
       Konstantin Kudin <konstantin_kudin@yahoo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Strange boot with multiple identical disks
References: <1076616510.16375.25.camel@shaggy.austin.ibm.com> <Pine.GSO.4.33.0402131029290.28488-100000@sweetums.bluetronic.net>
In-Reply-To: <Pine.GSO.4.33.0402131029290.28488-100000@sweetums.bluetronic.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricky Beam wrote:
> On Thu, 12 Feb 2004, Dave Kleikamp wrote:
> 
>>Redhat mounts the file systems by label.  I believe if you modify
>>/boot/grub/grub.conf and /etc/fstab to use the device names (/dev/hda*)
>>instead of LABEL=/, etc., then it should boot properly.  After wiping
>>out hdc, you can change them back to the way they were.
> 
> 
> It'll boot properly ONCE.  Redhat (in their ever increasing stupidity)
> converts fstab to labels on every boot.  Remove kudzu and this won't
> happen anymore. (or mark /etc/fstab as immutable and then NOTHING can
> change it.)

Or change the label to be unique on each filesystem, of course. There's 
nothing magic about the names having to be the mount points, or wasn't 
the last time I had this problem.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
