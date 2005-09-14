Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965253AbVINR1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965253AbVINR1I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 13:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965249AbVINR1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 13:27:08 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:16134 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S965253AbVINR1G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 13:27:06 -0400
Message-ID: <43285EF1.1040003@tmr.com>
Date: Wed, 14 Sep 2005 13:33:37 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Ok, it's been two weeks (actually, two weeks and one day) since 2.6.13, 
> and that means that the merge window is closed. I've released a 
> 2.6.14-rc1, and we're now all supposed to help just clean up and fix 
> everything, and aim for a really solid 2.6.14 release.

I can bore the list with a config, but this seems pretty common over x86 
configs, similar happened on desktop (this one), laptop, and server builds.
========================

   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CC      init/version.o
   LD      init/built-in.o
   LD      .tmp_vmlinux1
arch/i386/kernel/built-in.o(.init.text+0xe5e): In function 
`parse_cmdline_early':
: undefined reference to `disable_timer_pin_1'
arch/i386/kernel/built-in.o(.init.text+0xe7e): In function 
`parse_cmdline_early':
: undefined reference to `disable_timer_pin_1'
make[2]: *** [.tmp_vmlinux1] Error 1
error: Bad exit status from /var/tmp/rpm-tmp.82653 (%build)


RPM build errors:
     Bad exit status from /var/tmp/rpm-tmp.82653 (%build)
make[1]: *** [rpm] Error 1
make: *** [rpm] Error 2


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
