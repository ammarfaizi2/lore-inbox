Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVEWGn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVEWGn7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 02:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVEWGn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 02:43:59 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:1482 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261272AbVEWGn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 02:43:56 -0400
Date: Mon, 23 May 2005 12:12:29 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Borislav Petkov <petkov@uni-muenster.de>
Cc: vgoyal@in.ibm.com, coywolf@lovecn.org,
       Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       linux-kernel@vger.kernel.org,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: kexec?
Message-ID: <20050523064229.GA3611@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20050508202050.GB13789@charite.de> <200505180958.03570.petkov@uni-muenster.de> <20050520105259.GC3637@in.ibm.com> <200505211020.35982.petkov@uni-muenster.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505211020.35982.petkov@uni-muenster.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2005 at 10:20:35AM +0200, Borislav Petkov wrote:
> <snip>
> > Second kernel did not have serial console output enabled in config file. Is
> > it possible to test it out once again with serial console enabled. May be
> > disable kgdb in first kernel.
> >
> > With --console-serial option enabled while loading panic kernel (kexec -p)
> > I am expecting at least following message on serial console after Sysrq-c.
> >
> > "I am in purgatory".
> >
> HI Vivek,
> 
> well kgdb was the offending problem here. After disabling it and booting into 
> the first kernel, everything worked just fine. I even got to 
> save /proc/vmcore successfully so kdump works also :) Log attached.
> 
> Regards,
> Boris.

Thanks Boris, I have updated this on the test webpage. I have also noted the 
issue of kgdb interactions.

http://lse.sourceforge.net/kdump/kdump-test.html


Thanks
Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
