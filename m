Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285089AbRLFNIV>; Thu, 6 Dec 2001 08:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285130AbRLFNIE>; Thu, 6 Dec 2001 08:08:04 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:18111 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S285089AbRLFNHm>; Thu, 6 Dec 2001 08:07:42 -0500
Message-ID: <3C0F6D99.8CF24014@redhat.com>
Date: Thu, 06 Dec 2001 13:07:37 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] [RFC] [PATCH] Scalable Statistics Counters
In-Reply-To: <OF29EF801E.F851F18D-ON85256B19.00510775@raleigh.ibm.com> <20011206180353.E20583@in.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai wrote:
> 
> Hi Niels,
> 
> On Wed, Dec 05, 2001 at 10:02:33AM -0500, Niels Christiansen wrote:
> >
> > I'm wondering about the scope of this.  My Ethernet adapter with, maybe, 20
> > counter fields would have 20 counters allocated for each of my 16
> > processors.
> > The only way to get the total would be to use statctr_read() to merge them.
> > Same for the who knows how many IP counters etc., etc.
> 
> Are you concerned with increase in memory used per counter Here? I suppose
> that must not be that much of an issue for a 16 processor box....
> 
> >
> > How many and which counters were converted for the test you refer to?
> >
> 
> Well, I wrote a simple kernel module which just increments a shared global
> counter a million times per processor in parallel, and compared it with
> the statctr which would be incremented a million times per processor in
> parallel..

Would you care to point out a statistic in the kernel that is
incremented 
more than 10.000 times/second ? (I'm giving you a a factor of 100 of
playroom 
here) [One that isn't per-cpu yet of course]

 
Greetings,
   Arjan van de Ven
