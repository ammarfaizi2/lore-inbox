Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315560AbSEHX1q>; Wed, 8 May 2002 19:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315561AbSEHX1p>; Wed, 8 May 2002 19:27:45 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:58614 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S315560AbSEHX1o>;
	Wed, 8 May 2002 19:27:44 -0400
Message-ID: <3CD9B44F.4A023A70@mvista.com>
Date: Wed, 08 May 2002 16:27:11 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Philippe Troin <phil@fifi.org>
CC: vda@port.imtp.ilyichevsk.odessa.ua, Amol Lad <dal_loma@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: kill task in TASK_UNINTERRUPTIBLE
In-Reply-To: <20020508140124.79124.qmail@web12408.mail.yahoo.com>
		<200205081519.g48FJEX24062@Port.imtp.ilyichevsk.odessa.ua> <87znzawpk9.fsf@ceramic.fifi.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe Troin wrote:
> 
> Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> writes:
> 
> > On 8 May 2002 12:01, Amol Lad wrote:
> > > Hi,
> > >  Is there any way i can kill a task in
> > > TASK_UNINTERRUPTIBLE state ?
> >
> > No. Everytime you see hung task in this state
> > you see kernel bug.
> >
> > Somebody correct me if I am wrong.
> 
> Except for processes accessing NFS files while the NFS server is down:
> they will be stuck in TASK_UNINTERRUPTIBLE until the NFS server comes
> back up again.

A REALLY good argument for puting timeouts on your NSF mounts!  Don't
leave home without them.

-g

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
