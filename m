Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263192AbSJFCne>; Sat, 5 Oct 2002 22:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263240AbSJFCne>; Sat, 5 Oct 2002 22:43:34 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:21258 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S263192AbSJFCne>; Sat, 5 Oct 2002 22:43:34 -0400
Date: Sat, 5 Oct 2002 19:49:02 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Unable to kill processes in D-state
Message-ID: <20021006024902.GB31878@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20021005090705.GA18475@stud.ntnu.no> <1033841462.1247.3716.camel@phantasy> <20021005182740.GC16200@vagabond> <20021005235614.GC25827@stud.ntnu.no> <20021006021802.GA31878@pegasys.ws> <1033871869.1247.4397.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033871869.1247.4397.camel@phantasy>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2002 at 10:37:48PM -0400, Robert Love wrote:
> On Sat, 2002-10-05 at 22:18, jw schultz wrote:
> 
> > They shouldn't be affecting the load average because they
> > aren't on the runqueue.
> 
> TASK_UNINTERRUPTIBLE processes are counted in count_active_tasks() -
> because it is assumed they will only sleep a very short while - which is
> what is used in the load balance.

I stand corrected.  The load average reported will reflect
them.  The D-state processes, however, will have nearly zero
effect on the system performance, yes?  So in this case the
load average reported is simply an infated number.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
