Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270651AbTHFQd4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 12:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270329AbTHFQdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 12:33:06 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:18444 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S269994AbTHFQbZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 12:31:25 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-test2-mm3-1: Badness in class_dev_release followed by 5 NFS server hangs
Date: Thu, 7 Aug 2003 00:26:34 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, Joshua Kwan <joshk@triplehelix.org>,
       "Zephaniah E. Hull" <warp@mercury.d2dc.net>
References: <200308040328.26830.mflt1@micrologica.com.hk> <20030803135641.49d6316e.akpm@osdl.org> <200308040953.42110.mflt1@micrologica.com.hk>
In-Reply-To: <200308040953.42110.mflt1@micrologica.com.hk>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308070026.34483.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 August 2003 11:10, Michael Frank wrote:
> On Monday 04 August 2003 04:56, Andrew Morton wrote:
> > All netdevices will generate this warning on unregistration.  The net
> > guys are cooking up a fix, but it is not available yet.
>
> OK, What about the NFS hangs there are more now, also some short in
> duration
>
> Aug  4 04:22:02 mhfl4 kernel: nfs: server mhfl2 not responding, still
> trying Aug  4 04:22:02 mhfl4 kernel: nfs: server mhfl2 OK
> Aug  4 04:23:59 mhfl4 kernel: nfs: server mhfl2 not responding, still
> trying Aug  4 04:23:59 mhfl4 kernel: nfs: server mhfl2 OK
>

Running -mm4 for 2 days, spurious NFS server hangs seem to have 
subsided in -mm4

Regards
Michael


-- 
Powered by linux-2.6-test2-mm4. Compiled with gcc-2.95-3 - mature and rock solid

2.4/2.6 kernel testing: ACPI PCI interrupt routing, PCI IRQ sharing, swsusp
2.6 kernel testing:     PCMCIA yenta_socket, Suspend to RAM with ACPI S1-S3

More info on swsusp: http://sourceforge.net/projects/swsusp/

