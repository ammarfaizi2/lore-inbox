Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbTIORaj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 13:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbTIORaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 13:30:39 -0400
Received: from bgp01360964bgs.sandia01.nm.comcast.net ([68.35.68.128]:30856
	"EHLO orion.dwf.com") by vger.kernel.org with ESMTP id S261164AbTIORai
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 13:30:38 -0400
Message-Id: <200309151730.h8FHUSqg031978@orion.dwf.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: reg@dwf.com, linux-kernel@vger.kernel.org, reg@orion.dwf.com
Subject: Re: 2.6.0-test5: "No module aic7xxx found for kernel 2.6.0-test5, 
 aborting."
In-Reply-To: Message from "Randy.Dunlap" <rddunlap@osdl.org> 
   of "Mon, 15 Sep 2003 09:53:54 PDT." <20030915095354.6f28eedd.rddunlap@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 15 Sep 2003 11:30:28 -0600
From: reg@dwf.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, 13 Sep 2003 01:25:14 -0600 reg@dwf.com wrote:
> 
> | When trying to build SCSI support into 2.6.0-test5, 
> | I configure SCSI, but
> | whether I configure NO driver at all
> | or configure the aic7xxx driver
> | when I get to the 
> |     make install
> | I constantly get the error message  
> |     No module aic7xxx found for kernel 2.6.0-test5, aborting.
> | 
> | Surely SOMEONE has built this kernel with SCSI support, 
> | so why is it giving me this trouble.
> | 
> | I can probably build w/o ANY SCSI support at all, but that wouldnt be
> | useful, so I havent tried...
> 
> I build and boot with aic7xxx built into vmlinux all the time.
> However, I don't use 'make install' so I haven't seen this.
> If noone else knows the answer to this problem, perhaps you could
> debug install.sh or /sbin/installkernel (if those are being used).
> 

I hadn't even thought of that.
Ive been using 'make install', as a convenience, ever since it first appeared,
and just never thought about going back to doing things by hand/the good old
way.  I will take a look at the script tho, and try to see what it is doing
wrong.
-- 
                                        Reg.Clemens
                                        reg@dwf.com


