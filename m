Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311644AbSCNQFH>; Thu, 14 Mar 2002 11:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311643AbSCNQE5>; Thu, 14 Mar 2002 11:04:57 -0500
Received: from relay1.pair.com ([209.68.1.20]:21764 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S311642AbSCNQEk>;
	Thu, 14 Mar 2002 11:04:40 -0500
X-pair-Authenticated: 24.126.75.99
Message-ID: <3C90CC8A.EF09EE83@kegel.com>
Date: Thu, 14 Mar 2002 08:15:06 -0800
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave McCracken <dmccr@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: libc/1427: gprof does not profile threads <synopsis of the problem
In-Reply-To: <E16lWD3-0000sj-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken <dmccr@us.ibm.com> wrote:
> > It even looks like kernel support is included 2.4.19-pre3:
> > 
> > http://oss.software.ibm.com/pthreads/
> > 
> > But don't see anything about it in any of the recent change logs...
> 
> The relevant line from the changelog is:
> 
> - Signal changes for thread groups                      (Dave McCracken)
> 
> This is the only patch that NGPT needs to work.

Does NGPT support profiling yet?  i.e. can I compile a program
using -pg and NGPT, and view the runtime distribution histogram
with gprof?

- Dan
