Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264958AbRGEMLm>; Thu, 5 Jul 2001 08:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264973AbRGEMLd>; Thu, 5 Jul 2001 08:11:33 -0400
Received: from gherkin.sa.wlk.com ([192.158.254.49]:516 "HELO
	gherkin.sa.wlk.com") by vger.kernel.org with SMTP
	id <S264958AbRGEMLW>; Thu, 5 Jul 2001 08:11:22 -0400
Message-Id: <m15I7yD-0005khC@gherkin.sa.wlk.com>
From: rct@gherkin.sa.wlk.com (Bob_Tracy)
Subject: Re: PROBLEM: [2.4.6] kernel BUG at softirq.c:206!
In-Reply-To: <E15I79i-0002NI-00@the-village.bc.nu> "from Alan Cox at Jul 5, 2001
 12:18:46 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 5 Jul 2001 07:10:57 -0500 (CDT)
CC: Mircea Damian <dmircea@kappa.ro>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > This bug hits me since 2.4.6-pre5 but nobody answered to my emails... The
> > code line is identical (and the softirq.c:206 ofc).
> > 
> > Anyone, any idea?
> 
> None at all. There are odd items in your config - like khttpd which if 
> involved might explain why there are not more reports.

Add me to the list :-(.  Like the other folks reporting the softirq.c:206
panic problem, I've got a Cyrix.  Mine's a MII 300 (233 MHz).  Works fine
with 2.4.5 and prior kernels.  Didn't try any of the pre-2.4.6 or -ac
kernels.  Oops report available on request, but it's similar if not
identical to one I saw posted earlier.

--Bob Tracy
rct@frus.com
