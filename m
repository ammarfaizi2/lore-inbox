Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267737AbUJOM2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267737AbUJOM2G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 08:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267739AbUJOM2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 08:28:06 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:31379 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S267737AbUJOM2B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 08:28:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Oct 2004 08:27:10 -0400 (EDT)
To: Lee Revell <rlrevell@joe-job.com>
Cc: Robert Wisniewski <bob@watson.ibm.com>, Roland Dreier <roland@topspin.com>,
       karim@opersys.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Zanussi <trz@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U0
In-Reply-To: <1097806897.2682.80.camel@krustophenia.net>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
	<20041011215909.GA20686@elte.hu>
	<20041012091501.GA18562@elte.hu>
	<20041012123318.GA2102@elte.hu>
	<20041012195424.GA3961@elte.hu>
	<20041013061518.GA1083@elte.hu>
	<20041014002433.GA19399@elte.hu>
	<416F0071.3040304@opersys.com>
	<20041014234603.GA22964@elte.hu>
	<416F14B4.8070002@opersys.com>
	<52u0swddpk.fsf@topspin.com>
	<16751.12005.419748.661651@kix.watson.ibm.com>
	<1097806897.2682.80.camel@krustophenia.net>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <16751.49412.433407.262686@kix.watson.ibm.com>
From: Robert Wisniewski <bob@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell writes:
 > On Thu, 2004-10-14 at 22:00, Robert Wisniewski wrote:
 > > Theoretically a problem, in practice not, i.e., good enough for soft/normal
 > > real-time, not hard real-time; probably wouldn't want my heart monitor on
 > > it, but then I wouldn't be using Linux for that either :-)
 > 
 > Also, the issue here is how we do debug logging.  You would presumably
 > not use this at all in production.
 > 
 > Lee 

Yes actually you would.  If the tracing subsystem is designed correctly you
leave it in for production systems and enable it when you need to find a
problem.  The reason is because many times you can not reproduce a problem
someone in production is seeing in your environment.  In addition to the
LTT/Relayfs and K42 tracing work, lots of of tracing work/papers suggest
leaving it in all the time.  Most commercial operating systems have made
the investment to correctly design tracing facilities so they are
available.  LTT in combination with relayfs could fulfill that role for
Linux.

Robert Wisniewski
The K42 MP OS Project
Advanced Operating Systems
Scalable Parallel Systems
IBM T.J. Watson Research Center
914-945-3181
http://www.research.ibm.com/K42/
bob@watson.ibm.com
