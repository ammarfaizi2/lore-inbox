Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWHBVku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWHBVku (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 17:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWHBVkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 17:40:49 -0400
Received: from xenotime.net ([66.160.160.81]:22251 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932235AbWHBVkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 17:40:49 -0400
Date: Wed, 2 Aug 2006 14:43:27 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Brian D. McGrew" <brian@visionpro.com>
Cc: "For users of Fedora Core releases" <fedora-list@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Problems with mtpscsih kernel module
Message-Id: <20060802144327.c757c40c.rdunlap@xenotime.net>
In-Reply-To: <14CFC56C96D8554AA0B8969DB825FEA0012B3941@chicken.machinevisionproducts.com>
References: <14CFC56C96D8554AA0B8969DB825FEA0012B3941@chicken.machinevisionproducts.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2006 14:26:48 -0700 Brian D. McGrew wrote:

> Running on a Dell PowerEdge 1800 using Fedora Core 3 and a 2.6.16.16
> kernel.
> 
> I've built up this new kernel to roll out to our production systems and
> it's been in test on a PE1800 for a long time and working fine.
> However, the machine that it's been testing on has SATA drives.
> Yesterday I moved it to a production system, another PE1800 with SCSI
> drives and I'm getting an error
> 
> Insmod /lib/modules/mptscshih.ko: -l unknown symbol
> 
> The only differences I can find between the two machines is that the
> original build/test machine has gcc-3.4.4 and the new machine has
> gcc-3.4.2; but it looks like all the system libraries are the same and
> everything else.
> 
> I even went so far as to move the entire source tree to this machine and
> do a make clean and rebuild and reinstall and I'm still having the same
> problem.  What am I missing here???  

The kernel message log should have a list of the missing
symbol(s) that are needed.  Please post that.

---
~Randy
