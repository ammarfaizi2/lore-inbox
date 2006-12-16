Return-Path: <linux-kernel-owner+w=401wt.eu-S1753194AbWLPBtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194AbWLPBtT (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 20:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbWLPBtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 20:49:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47716 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753194AbWLPBtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 20:49:19 -0500
Date: Fri, 15 Dec 2006 17:47:50 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18.5 usb/sysfs bug.
Message-Id: <20061215174750.e1389c0d.zaitcev@redhat.com>
In-Reply-To: <20061215213715.GB15792@redhat.com>
References: <20061215175027.GA17987@redhat.com>
	<20061215175344.GA15871@kroah.com>
	<20061215213715.GB15792@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.6; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2006 16:37:15 -0500, Dave Jones <davej@redhat.com> wrote:

> Linux version 2.6.18-1.2864.fc6 (brewbuilder@hs20-bc2-4.build.redhat.com) (gcc version 4.1.1 20061011 (Red Hat 4.1.1-30)) #1 SMP Fri Dec 15 13:14:58 EST 2006
> Kernel command line: ro root=/dev/VolGroup00/LogVol00 profile=1 vga=791

> audit(1166218060.464:4): avc:  denied  { search } for  pid=2678 comm="pcscd" name="usbdev2.4_ep03" dev=sysfs ino=1384 scontext=system_u:system_r:pcscd_t:s0 tcontext=system_u:object_r:sysfs_t:s0 tclass=dir
> BUG: unable to handle kernel NULL pointer dereference at virtual address 0000000b

But if you boot with selinux=0, everything works, right? Printk time.

-- Pete
