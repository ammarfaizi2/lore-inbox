Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbUBVMpo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 07:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbUBVMpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 07:45:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21383 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261241AbUBVMpn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 07:45:43 -0500
Date: Sun, 22 Feb 2004 12:45:41 +0000
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel Cross Compiling [update]
Message-ID: <20040222124541.GA1064@gallifrey>
References: <20040222035350.GB31813@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040222035350.GB31813@MAIL.13thfloor.at>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.3 (i686)
X-Uptime: 12:38:51 up 13:19,  1 user,  load average: 0.00, 0.28, 0.66
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Herbert Poetzl (herbert@13thfloor.at) wrote:
> 
> Hi Folks!
> 
> Here is an update to the Kernel Cross Compiling thread 
> I started ten days ago ...

Hi,
   Quite a while ago I tried going through a similar
process.   I found at the time the debian toolchain-source
package helped in this process.

There is however one thing you seem to have missed - you
tend to need subtely different versions of gcc and binutils
for each combination.

It certainly used to be the case that every architectures
kernel used to have different known issues in both gcc
and binutils; and there was a fair amount of 'oh don't
use that version, it produces broken kernels' with
different answers for each architecture.

At one time I tried to make a summary page showing where
the kernel source and tools are for each architecture;
but I never kept it upto date.
(http://www.treblig.org/Linux_kernel_source_finder.html)

Dave

 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
