Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318506AbSGSMwp>; Fri, 19 Jul 2002 08:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318510AbSGSMwp>; Fri, 19 Jul 2002 08:52:45 -0400
Received: from holomorphy.com ([66.224.33.161]:10895 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318506AbSGSMwo>;
	Fri, 19 Jul 2002 08:52:44 -0400
Date: Fri, 19 Jul 2002 05:55:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Bob_Tracy <rct@gherkin.frus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.2[5-6] VM problem (oops)
Message-ID: <20020719125518.GX1096@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Bob_Tracy <rct@gherkin.frus.com>, linux-kernel@vger.kernel.org
References: <m17VX7e-0005khC@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <m17VX7e-0005khC@gherkin.frus.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2002 at 07:44:38AM -0500, Bob_Tracy wrote:
> Unfortunately, this report is not as detailed as it needs to be (can't
> run ksymoops while the affected kernels are running).  2.5.25 and 2.5.26
> both seem to have this problem, whereas 2.5.24 and earlier kernels are
> fine.  Problem is that kernel will generally "oops" within 24 hours of
> booting.  The process that triggers the oops isn't constant, but the
> general character of the oops *is*...  Here's the log, such as it is:
> kernel BUG at page_alloc.c:182!


(1) if you read the ksymoops manpage you'll see how to run it on a
	non-running kernel, read how to point it at a System.map
	and modules directory of your choosing and avoid using the
	/proc/ksyms of the running kernel there please
(2) to cut down on the number of variables, please reproduce it while
	the NVidia driver is not loaded and decode that ksymoops

It's not particularly useful to post non-decoded oopses.


Cheers,
Bill
