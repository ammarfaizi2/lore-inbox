Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281274AbRLAAv3>; Fri, 30 Nov 2001 19:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281252AbRLAAvT>; Fri, 30 Nov 2001 19:51:19 -0500
Received: from host133.bigidea.com ([38.196.61.133]:48041 "EHLO
	wolverine.bigidea.com") by vger.kernel.org with ESMTP
	id <S281232AbRLAAvD>; Fri, 30 Nov 2001 19:51:03 -0500
Date: Fri, 30 Nov 2001 18:49:16 -0600
From: "Joe Rice" <jrice@bigidea.com>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Still having problems with eepro100
Message-ID: <20011130184916.A13868@bigidea.com>
In-Reply-To: <20011130180827.E2265@bigidea.com> <20011130163721.J504@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20011130163721.J504@mikef-linux.matchmail.com>; from mfedyk@matchmail.com on Fri, Nov 30, 2001 at 04:37:21PM -0800
X-Arbitrary-Number-Of-The-Day: 42
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i guess that explains why i haven't seen the problem again
on the bed of machines with 2.4.16.  
Could please explain how you came to your answer?
maybe this is to obvious to be addressed on the list, but
please give me a clue.

thanks,
joe

www.bigidea.com 

Mike Fedyk(mfedyk@matchmail.com)@Fri, Nov 30, 2001 at 04:37:21PM -0800:
> On Fri, Nov 30, 2001 at 06:08:27PM -0600, Joe Rice wrote:
> > 
> > Hello, 
> >   I'm having the same type of problems that was talked
> > about in this thread.  I have seen the same error
> > on kernels 2.4.7 - 2.4.10, which is:
> > 
> > eth0: card reports no resources.
> > __alloc_pages: 0_order allocation failed (gfp=0x20/0) from c012da00
> >
> > at which point i see NFS timeouts or the machine hangs
> > and requires a cold reboot.
> >
> > also, I haven't had any luck with the Intel e100 driver.
> >
> 
> e100 probably doesn't help because that is a VM issue triggered by nfs and
> networking.
> 
> > 
> > I'm now testing on 10 of the nodes the 2.4.16 kernel.  They
> > have been under a moderate load and i haven't seen any
> > problems yet.  I still plan on doing a large load test
> > on this newer kernel.
> > 
> 
> Let us know if there's any problems.  And if things are better that wouldn't
> hurt reporting either ;)
