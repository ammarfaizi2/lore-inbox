Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266311AbUHBHBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266311AbUHBHBW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 03:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266316AbUHBG7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 02:59:48 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:25361 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S266322AbUHBG5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 02:57:46 -0400
Message-ID: <410DE6B3.2040405@hist.no>
Date: Mon, 02 Aug 2004 09:01:07 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mingo@redhat.com, Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-O2 didn't link
References: <20040713143947.GG21066@holomorphy.com> <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
In-Reply-To: <20040801193043.GA20277@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>here's the latest version of the voluntary-preempt patch:
>  
>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-O2
>  
>
This didn't link:

  CC      arch/i386/lib/usercopy.o
  AR      arch/i386/lib/lib.a
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
init/built-in.o(.text+0x1be): In function `init':
init/main.c:708: undefined reference to `spawn_irq_threads'
make: *** [.tmp_vmlinux1] Error 1

Helge Hafting
