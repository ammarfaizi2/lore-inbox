Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317112AbSHBVdx>; Fri, 2 Aug 2002 17:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317211AbSHBVdx>; Fri, 2 Aug 2002 17:33:53 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:30619 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317112AbSHBVdw>; Fri, 2 Aug 2002 17:33:52 -0400
To: "Aneesh Kumar K.V" <aneesh.kumar@digital.com>
Cc: Camm Maguire <camm@enhanced.com>,
       debian-alpha <debian-alpha@lists.debian.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: SA_SIGINFO in Linux 2.4.x
References: <E17aOg0-0002ub-00@intech19.enhanced.com>
	<1028281936.17352.42.camel@satan.xko.dec.com>
From: Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>
Date: 02 Aug 2002 23:36:40 +0200
In-Reply-To: <1028281936.17352.42.camel@satan.xko.dec.com>
Message-ID: <87wur92b9z.fsf@mrvn.homelinux.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@digital.com> writes:

> On Fri, 2002-08-02 at 04:14, Camm Maguire wrote:
> > Greetings!  The 2.4.x kernels on alpha don't appear to be filling in
> > the si_addr element of the siginfo_t structure when a signal handler
> > is setup with SA_SIGINFO.  Is this right?  Any other way to get this
> > address in the handler?
> > 
> > Take care,
> > 
> > -- 
> > Camm Maguire			     			camm@enhanced.com
> 
> 
> Hi, 
> 
>  Try the following patch  for arch/alpha/mm/fault.c 

Thats no based on the patch I did a while back, is it?

MfG
        Goswin
