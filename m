Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264289AbTKZTnq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 14:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264294AbTKZTnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 14:43:46 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:61359 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S264289AbTKZTno
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 14:43:44 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: amanda vs 2.6
Date: Wed, 26 Nov 2003 14:43:43 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200311261212.10166.gene.heskett@verizon.net> <200311261415.52304.gene.heskett@verizon.net> <20031126193059.GS8039@holomorphy.com>
In-Reply-To: <20031126193059.GS8039@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311261443.43695.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.54.127] at Wed, 26 Nov 2003 13:43:43 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 November 2003 14:30, William Lee Irwin III wrote:
>On Wednesday 26 November 2003 12:19, William Lee Irwin III wrote:
>>> echo 1 > /proc/sys/vm/overcommit_memory
>
>On Wed, Nov 26, 2003 at 02:15:52PM -0500, Gene Heskett wrote:
>> Unforch, this seems to have fubared the system, and I will have to
>> reboot as I cannot (it hangs) do an "su amanda" after executeing
>> this.

I forgot in case you aren't fam with amanda, much of it will not run 
as any user but its own user, in this case amanda.  Security etc.

>Sounds like trouble. Are there any external signs of what's going
> on? e.g. is the disk thrashing?

No, it just hangs forever on the su command, never coming back.  
everything else I tried, which wasn't much, seemed to keep on working 
as I sent that message with that hung su process in another shell on 
another window.  I'm an idiot, normally running as root...

I've rebooted, not knowing if an echo 0 to that variable would fix it 
or not, I see after the reboot the default value is 0 now.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

