Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271665AbTGRBEg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 21:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271666AbTGRBEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 21:04:36 -0400
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:29318 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S271665AbTGRBEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 21:04:35 -0400
X-Originating-IP: [62.254.0.11]
From: <steven.newbury1@ntlworld.com>
To: Oleg Drokin <green@namesys.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Re: lots of oopses with recent kernels
Date: Fri, 18 Jul 2003 1:19:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Message-Id: <20030718011930.ZALH2652.mta03-svc.ntlworld.com@[10.137.100.63]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> From: Oleg Drokin <green@namesys.com>
> Date: 2003/07/17 Thu AM 10:13:38 GMT
> To: steven.newbury1@ntlworld.com
> CC: linux-kernel@vger.kernel.org
> Subject: Re: lots of oopses with recent kernels
> 
> Hello!
> 
> On Wed, Jul 16, 2003 at 11:35:55PM +0000, steven.newbury1@ntlworld.com wrote:
> 
> > I am using gcc version 3.3 20030623 (Red Hat Linux 3.3-12)
> > so that may be to blame...
> > ...but I have received the bellow oopses while copying files to a "Device-Mapper" striped device with
> > 'tar cf - . | tar - -C /mnt/tmp'
> > oops1: reiserfs format device (with BadRAM patch)
> > oops2: ext2/3 format device (with BadRAM patch)
> > oops3: reiserfs format device (with mem=320M BadRAM patch
> >        removed.
> 
> Sigh, I see lots of times your kernel jumps at random addresses for no good reason.
> (like in 2 out of your four oopses you attached).
> Have you tried to compile without CONFIG_PREEMPT just to see if it will be any better?
> 
> Bye,
>     Oleg
> 

Part of the problem is due to a bug in my BadRAM patch though I am unable to find it. :-(

Any chance any of the oopses pointed to anything w.r.t. the BadRAM patch?

I am now running with CONFIG_PREEMT=n and without BadRAM.  I don't trust my Promise IDE controller, it might also be causing problems, I am getting IDE errors off of it with the  Barracuda's.  I have ordered a new one, which should arrive  in the morning (Friday).  I will let you know how it goes...


-----------------------------------------
Email provided by http://www.ntlhome.com/


