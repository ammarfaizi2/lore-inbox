Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132587AbRASUtr>; Fri, 19 Jan 2001 15:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132867AbRASUth>; Fri, 19 Jan 2001 15:49:37 -0500
Received: from gateway.sequent.com ([192.148.1.10]:39305 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S132587AbRASUtb>; Fri, 19 Jan 2001 15:49:31 -0500
Date: Fri, 19 Jan 2001 12:49:21 -0800
From: Mike Kravetz <mkravetz@sequent.com>
To: Andrea Arcangeli <andrea@suse.de>,
        Davide Libenzi <davidel@xmail.virusscreen.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: multi-queue scheduler update
Message-ID: <20010119124921.G26968@w-mikek.des.sequent.com>
In-Reply-To: <20010118155311.B8637@w-mikek.des.sequent.com> <20010119012616.D32087@athlon.random> <20010118165225.E8637@w-mikek.des.sequent.com> <20010119023041.F32087@athlon.random> <20010118173435.K8637@w-mikek.des.sequent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010118173435.K8637@w-mikek.des.sequent.com>; from mkravetz@sequent.com on Thu, Jan 18, 2001 at 05:34:35PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2001 at 05:34:35PM -0800, Mike Kravetz wrote:
> On Fri, Jan 19, 2001 at 02:30:41AM +0100, Andrea Arcangeli wrote:
> > On Thu, Jan 18, 2001 at 04:52:25PM -0800, Mike Kravetz wrote:
> > > was less than the number of processors.  I'll give the tests a try
> > > with a smaller number of threads.  I'm also open to suggestions for
> > 
> > OK!
> > 
> > > what benchmarks/test methods I could use for scheduler testing.  If
> > > you remember what people have used in the past, please let me know.
> > 
> > It was this one IIRC (it spawns threads calling sched_yield() in loop).
> 
> Thanks!

It was my intention to post IIRC numbers for small thread counts today.
However, the benchmark (not the system) seems to hang on occasion.  This
occurs on both the unmodified 2.4.0 kernel and the one which contains
my multi-queue patch.  Therefore, I'm pretty sure it is not something
I did. :)

Anyone else see anything like this before?  I'll look into the reason
for the hang, but it will delay my posting of these numbers.

-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
