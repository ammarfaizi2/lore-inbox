Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136772AbREAXbO>; Tue, 1 May 2001 19:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136773AbREAXbE>; Tue, 1 May 2001 19:31:04 -0400
Received: from pizda.ninka.net ([216.101.162.242]:52620 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136772AbREAXaz>;
	Tue, 1 May 2001 19:30:55 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15087.18144.149969.793821@pizda.ninka.net>
Date: Tue, 1 May 2001 16:29:36 -0700 (PDT)
To: Leif Sawyer <lsawyer@gci.com>
Cc: linux-kernel@vger.kernel.org, suse-sparc@suse.com
Subject: Re: DHCP comiling issues under sparc linux
In-Reply-To: <BF9651D8732ED311A61D00105A9CA3150446DC82@berkeley.gci.com>
In-Reply-To: <BF9651D8732ED311A61D00105A9CA3150446DC82@berkeley.gci.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Leif Sawyer writes:
 > Below is the end of a thread between myself and Ted Lemon
 > regarding building DHCP under Sparc Linux.
 > 
 > I'm not well versed in parsing the kernel code to know
 > what the subtle differences in the different implementations
 > of this IOCtl, and am looking for some guidance from the
 > appropriate maintainers.
 > 
 > Please read below for the summary. I'll be happy to fill
 > in the blanks off-list.

It is a bug if it behaves differently, without question.

Can you give a trace of a bad case?  The code looks fine to
me, but if I am shown a specific trace I may be able to see
the bug.

Please, this is an issue I have with many bug reports.  The
text of the report uses a lot of non-specific wording, "SIOCGIFCONF
with NULL arg gives different results on sparc64 than i386"  That
is great and gives me the gist of the problem, but without a specific
trace of arguments and results and a description of what is
specifically expected in this traced case compared to what actually
happened, I do a lot of guessing to work on a fix.

Later,
David S. Miller
davem@redhat.com
