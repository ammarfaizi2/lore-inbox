Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264984AbRFZPZ4>; Tue, 26 Jun 2001 11:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264988AbRFZPZq>; Tue, 26 Jun 2001 11:25:46 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:1294 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S264984AbRFZPZe>; Tue, 26 Jun 2001 11:25:34 -0400
Date: Tue, 26 Jun 2001 10:52:16 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: John Fremlin <vii@users.sourceforge.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: VM tuning through fault trace gathering [with actual code]
In-Reply-To: <m2n16vcsft.fsf@boreas.yi.org.>
Message-ID: <Pine.LNX.4.21.0106261031150.850-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 26 Jun 2001, John Fremlin wrote:

> Marcelo Tosatti <marcelo@conectiva.com.br> writes:
> 
> > On 25 Jun 2001, John Fremlin wrote:
> > 
> > > 
> > > Last year I had the idea of tracing the memory accesses of the system
> > > to improve the VM - the traces could be used to test algorithms in
> > > userspace. The difficulty is of course making all memory accesses
> > > fault without destroying system performance.
> 
> [...]
> 
> > Linux Trace Toolkit (http://www.opersys.com/LTT) does that. 
> 
> I dld the ltt-usenix paper and skim read it. It didn't seem to talk
> about page faults much. Where should I look?

Grab the source and try it out?

Example page fault trace: 

####################################################################
Event     	          Time                   PID     Length Description
####################################################################

Trap entry              991,299,585,597,016     678     12      TRAP: page fault; EIP : 0x40067785


