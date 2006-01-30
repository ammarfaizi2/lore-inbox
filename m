Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWA3HWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWA3HWe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 02:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWA3HWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 02:22:34 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:64455 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932122AbWA3HWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 02:22:33 -0500
Subject: Re: Rebuilding Linux kernel
From: Lee Revell <rlrevell@joe-job.com>
To: Heerath bh <heerath.bh@gmail.com>
Cc: kaos@ocs.wm.au, mec@shout.net, kbuild-devel@lists.sourceforge.net,
       alan@linuxcare.com.au, rtlinux@rtlinux.org, yodaiken@fsmlabs.com,
       linux-kernel@vger.kernel.org, cbrake@accelent.com,
       jsutherland@accelent.com
In-Reply-To: <aca19fda0601292303r5d3dba06kf40121a118f13c69@mail.gmail.com>
References: <aca19fda0601292303r5d3dba06kf40121a118f13c69@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 30 Jan 2006 02:22:22 -0500
Message-Id: <1138605742.2799.149.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-30 at 12:33 +0530, Heerath bh wrote:
> 
> Basically  I am trying to rebuild the kernel.I am trying to make two
> types of kernel.I am using Redhat 2.4 version on intel x86 machine.
> 1.Deployment level kernel
> 2.development level kernel.
> 
> Deployment Level kernel:This kernel has to be a Very vanilla kernel. I
> mean to say, it wil be having basic kernel services like:preemptive
> kernel,memory
> 
>  management,scheduling&synchronization,sysatem
> timers,IPC,Interrupt handling,multitasking.
> 

You will need 2.6 for this, 2.4 is inadeuate (no preemption).  2.6.14 or
2.6.15 is a good choice.

Lee

