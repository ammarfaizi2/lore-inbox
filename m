Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265928AbUHJOc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265928AbUHJOc4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 10:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266183AbUHJOc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 10:32:56 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:46298 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265928AbUHJOcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 10:32:54 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Lee Revell <rlrevell@joe-job.com>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <yw1xisbrflws.fsf@kth.se>
References: <1092082920.5761.266.camel@cube>
	 <cone.1092092365.461905.29067.502@pc.kolivas.org>
	 <1092099669.5759.283.camel@cube>  <yw1xisbrflws.fsf@kth.se>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1092148392.5818.6.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 10:33:13 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 04:16, Måns Rullgård wrote:
> Albert Cahalan <albert@users.sf.net> writes:
> 
> >> Last time I gave 
> >> superuser privilege to cdrecord it locked my machine - clearly it wasn't 
> >> rt_task safe.
> >
> > So, you've been working on the scheduler anyway...
> > An option to reserve some portion of CPU time for
> > emergency use (say, 5% after 1 second has passed)
> > would let somebody get out of this situation.
> 
> Another option would be an Alt-Sysrq-something that lowered all RT
> processes to normal levels.

I hate to derail a good flame-fest, but this would be extremely useful,
for more than burning CDs.  Anytime you are dealing with a SCHED_FIFO
process a bug can lock the machine, this would be useful for hacking
jackd for example.

If someone wants to code this up I and the other people on jackit-devel
would gladly test it.

Lee

