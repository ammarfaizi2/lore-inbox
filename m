Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbTINVFg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 17:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTINVFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 17:05:36 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:22682 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261386AbTINVFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 17:05:35 -0400
Date: Sun, 14 Sep 2003 22:04:29 +0100
From: Dave Jones <davej@redhat.com>
To: Russell Miller <rmiller@duskglow.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [SUMMARY] rebooting problem solved - athlon/SiS incompatibility.
Message-ID: <20030914210429.GA26027@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Russell Miller <rmiller@duskglow.com>, linux-kernel@vger.kernel.org
References: <20030914205429.GA3535@www.duskglow.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030914205429.GA3535@www.duskglow.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 14, 2003 at 03:54:29PM -0500, Russell Miller wrote:

 > Which basically seems to mean:  you cannot enable SMP and turn off coprocessor
 > emulation on an SiS motherboard containing an Athlon Thunderbird processor.  The
 > kernel will not even get past the "Ok, booting the kernel" stage.

Which option do you mean by 'Coprocessor emulation' ?
If you mean the math emulation, it doesn't get used on a machine
with a real FPU, so this doesn't make any sense.

Is your board actually an SMP capable board ?
The choice of thunderbirds in an SMP system is also curious.
Thunderbirds are model 4. The only models certified for use in
SMP are model 6 and above. (See arch/i386/kernel/smpboot line 136 or so)

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
