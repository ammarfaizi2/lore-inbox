Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264183AbRFTQnO>; Wed, 20 Jun 2001 12:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264240AbRFTQnE>; Wed, 20 Jun 2001 12:43:04 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:39922 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S264183AbRFTQnC>; Wed, 20 Jun 2001 12:43:02 -0400
Message-ID: <3B30D1AC.325A4CCB@mvista.com>
Date: Wed, 20 Jun 2001 09:39:08 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Jes Sorensen <jes@sunsite.dk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        bert hubert <ahu@ds9a.nl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
In-Reply-To: <Pine.GSO.4.21.0106201127350.24658-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On 20 Jun 2001, Jes Sorensen wrote:
> 
> > Not to mention how complex it is to get locking right in an efficient
> > manner. Programming threads is not that much different from kernel SMP
> > programming, except that in userland you get a core dump and retry, in
> > the kernel you get an OOPS and an fsck and retry.
> 
> Arrgh. As long as we have that "SMP makes locking harder" myth floating
> around we _will_ get problems. Kernel UP programming is not different
> from SMP one. It is multithreaded. And amount of genuine SMP bugs is
> very small compared to ones that had been there on UP since way back.
> And yes, programming threads is the same thing. No arguments here.
> 
Correct, IF the UP kernel is preemptable.  As long as it is not (and SMP
is ignored) threads are harder BECAUSE they are preemptable.

George
