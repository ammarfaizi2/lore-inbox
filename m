Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269818AbUJMU30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269818AbUJMU30 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 16:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269822AbUJMU27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 16:28:59 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:36857 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269818AbUJMU24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 16:28:56 -0400
Message-ID: <9625752b04101313283f035423@mail.gmail.com>
Date: Wed, 13 Oct 2004 13:28:55 -0700
From: Danny <dannydaemonic@gmail.com>
Reply-To: Danny <dannydaemonic@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: mm kernel oops with r8169 & named, PREEMPT
Cc: netdev@oss.sgi.com
In-Reply-To: <200410131129.05657.jdmason@us.ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9625752b041012230068619e68@mail.gmail.com>
	 <9625752b041013091772e26739@mail.gmail.com>
	 <9625752b04101309182a96fbd2@mail.gmail.com>
	 <200410131129.05657.jdmason@us.ltcfwd.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2004 11:29:05 -0500, Jon Mason wrote:
> Can you confirm that you are running r8169 driver with NAPI and TSO turned on,
> along with Preemptable Kernel?  Also, I didn't see anything in the Oops
> specific to the r8169 driver, do you have another adapter available to run
> the same test on?  Finally, what is your setup (arch, # of cpus, etc)?

I am using the r8169 driver with NAPI and preemptable kernel.  I don't
remember or see any option for offloading but it sounds like something
I'd turn on.  Let me know what I should look for in my config, or
check here:
http://members.cox.net/valenzdu/.config

I no longer have a 2nd nic adapter, but I did first notice the problem
when I installed this one.  However, if I don't load that module I'm
not able to duplicate the problem by running named on the other
interface.  Running named triggers it 100% of the time on the r8169
based nic.

The arch is x86 (athlon) with just 1 cpu.  Since I'm not sure what's
wrong here I'm not sure what's relevant.  Here is more info about my
setup:
http://members.cox.net/valenzdu/proc-cpuinfo
http://members.cox.net/valenzdu/proc-iomem
http://members.cox.net/valenzdu/proc-ioports
http://members.cox.net/valenzdu/proc-modules
http://members.cox.net/valenzdu/proc-version
http://members.cox.net/valenzdu/stdout-lspci
http://members.cox.net/valenzdu/stdout-ver_linux
