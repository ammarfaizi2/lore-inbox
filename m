Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262120AbUJZG5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbUJZG5w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 02:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbUJZG5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 02:57:52 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:154 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262120AbUJZG5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 02:57:47 -0400
Subject: Re: 2.6.9-mm1
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <417D7EB9.4090800@osdl.org>
References: <20041022032039.730eb226.akpm@osdl.org>
	 <417D7EB9.4090800@osdl.org>
Content-Type: text/plain
Message-Id: <1098773355.5807.10.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 26 Oct 2004 16:49:15 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2004-10-26 at 08:31, Randy.Dunlap wrote:
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9/2.6.9-mm1/
> > 
> > - Lots of new patches.
> > 
> >   - kexec and crashdump: this all allegedly works, but I want to *see* it
> >     work first.
> 
> Dual-proc P4, 1 GB RAM, IDE only, ext3fs:
> 
> 
> I'm trying to spend time on kexec++ this week, but this little BUG
> keeps getting in the way.  Has it already been reported/fixed?
> 
> kernel BUG at arch/i386/mm/highmem.c:42!
> invalid operand: 0000 [#1]
> SMP DEBUG_PAGEALLOC

I've seen this too when trying to get Suspend going under
DEBUG_PAGEALLOC (vanilla 2.6.9 IIRC - 2.6.8.1 otherwise). I'll be
looking to track down the cause anyway, so if noone else beats me to it,
I should have a better idea within a day or two (time-to-do-it
permitting).

Regards,

Nigel

-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Everyone lives by faith. Some people just don't believe it.
Want proof? Try to prove that the theory of evolution is true.

