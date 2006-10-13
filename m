Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWJMPmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWJMPmw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 11:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWJMPmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 11:42:52 -0400
Received: from pas38-1-82-67-71-117.fbx.proxad.net ([82.67.71.117]:58532 "EHLO
	siegfried.gbfo.org") by vger.kernel.org with ESMTP id S1751280AbWJMPmv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 11:42:51 -0400
Date: Fri, 13 Oct 2006 17:42:28 +0200 (CEST)
From: Jean-Marc Saffroy <saffroy@gmail.com>
X-X-Sender: saffroy@erda.mds
To: Steven Truong <midair77@gmail.com>
cc: Vivek Goyal <vgoyal@in.ibm.com>, linux-kernel@vger.kernel.org,
       crash-utility@redhat.com
Subject: Re: [Crash-utility] Re: kdump/kexec/crash on vmcore file
In-Reply-To: <20061013141446.GA27375@in.ibm.com>
Message-ID: <Pine.LNX.4.64.0610131727270.4785@erda.mds>
References: <28bb77d30610121450n6cfd9c6ejd6b0370d2400a378@mail.gmail.com>
 <20061013141446.GA27375@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven,

I see you tried using gdb, maybe a tool I wrote could help you:
   http://jeanmarc.saffroy.free.fr/kdump2gdb/

Basically it will convert the kdump core to a slightly different core that 
is suitable for gdb, as well as a gdb script that loads kernel modules at 
the right offsets. Then maybe you can grab a backtrace of the faulting 
process ("bt full" can be nice) and post it to l-k.


Cheers,

-- 
saffroy@gmail.com
