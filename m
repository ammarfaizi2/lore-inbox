Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136769AbREIRaq>; Wed, 9 May 2001 13:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136771AbREIRag>; Wed, 9 May 2001 13:30:36 -0400
Received: from mg02.austin.ibm.com ([192.35.232.12]:42749 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S136769AbREIRaY>; Wed, 9 May 2001 13:30:24 -0400
Message-ID: <3AF97EBB.9F0ABE9A@austin.ibm.com>
Date: Wed, 09 May 2001 12:30:35 -0500
From: "Andrew M. Theurer" <atheurer@austin.ibm.com>
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Kravetz <mkravetz@sequent.com>
CC: lse-tech@lists.sourceforge.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        samba-technical <samba-technical@samba.org>
Subject: Re: Linux 2.4 Scalability, Samba, and Netbench
In-Reply-To: <3AF97062.42465A53@austin.ibm.com> <20010509095658.B1150@w-mikek2.sequent.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I do have kernprof ACG and lockmeter for a 4P run.  We saw no
significant problems with lockmeter.  csum_partial_copy_generic was the
highest % in profile, at 4.34%.  I'll see if we can get some space on
http://lse.sourceforge.net to post the test data.

Andrew Theurer

Mike Kravetz wrote:
> 
> On Wed, May 09, 2001 at 11:29:22AM -0500, Andrew M. Theurer wrote:
> >
> > I am evaluating Linux 2.4 SMP scalability, using Netbench(r) as a
> > workload with Samba, and I wanted to get some feedback on results so
> > far.
> 
> Do you have any kernel profile or lock contention data?
> 
> --
> Mike Kravetz                                 mkravetz@sequent.com
> IBM Linux Technology Center
