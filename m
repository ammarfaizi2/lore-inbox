Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289240AbSA1Qvl>; Mon, 28 Jan 2002 11:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289243AbSA1Qvb>; Mon, 28 Jan 2002 11:51:31 -0500
Received: from relay2.uni-heidelberg.de ([129.206.210.211]:57583 "EHLO
	relay2.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S289240AbSA1QvP>; Mon, 28 Jan 2002 11:51:15 -0500
Message-Id: <200201281651.g0SGp7911439@fubini.pci.uni-heidelberg.de>
Content-Type: text/plain; charset=US-ASCII
From: Bernd Schubert <bernd-schubert@web.de>
To: Robert Love <rml@tech9.net>
Subject: Re: kernel BUG at slab.c:1200!
Date: Mon, 28 Jan 2002 17:51:07 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200201241906.g0OJ68915057@fubini.pci.uni-heidelberg.de> <1011966573.3501.1.camel@phantasy>
In-Reply-To: <1011966573.3501.1.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we have removed a buggy RAM module but have other problems now (and don't see 
the reasing why -- lots of kernel messages about defect hardware and doubly 
reserved IRQ's; though its booting the kernel, but becomes very, very slow 
now; I think its time to call the warranty hotline for a hardware damage). 
Sorry but currently the machine is definetely not able to do a kernel 
debugging. When its up and running again, we will try to run ksymoops.

Thanks for your help,

Bernd

On Friday 25 January 2002 14:49, Robert Love wrote:
> On Thu, 2002-01-24 at 14:06, Bernd Schubert wrote:
> > we have a machine here that runs quite instable, with 2.2.16 it was
> > crashing quite often and now after a big system update it also crashes
> > with 2.4.17.
> > But at least /var/log/messages shows the following errors:
>
> Hi.  The BUG is caused by extra checks on free present by the slab
> debugging you have enabled.  I suspect you wouldn't notice a thing if
> you turned debugging off ;)
>
> That said, you need to run the oops through ksymoops so we can get a
> back trace and see who the offending caller is.
>
> 	Robert Love

