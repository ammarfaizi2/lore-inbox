Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265225AbRGEN7o>; Thu, 5 Jul 2001 09:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265189AbRGEN7e>; Thu, 5 Jul 2001 09:59:34 -0400
Received: from gherkin.sa.wlk.com ([192.158.254.49]:43780 "HELO
	gherkin.sa.wlk.com") by vger.kernel.org with SMTP
	id <S264883AbRGEN7V>; Thu, 5 Jul 2001 09:59:21 -0400
Message-Id: <m15I9eu-0005khC@gherkin.sa.wlk.com>
From: rct@gherkin.sa.wlk.com (Bob_Tracy)
Subject: Re: PROBLEM: [2.4.6] kernel BUG at softirq.c:206!
In-Reply-To: <E15I8gj-0002W7-00@the-village.bc.nu> "from Alan Cox at Jul 5, 2001
 01:56:57 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 5 Jul 2001 08:59:08 -0500 (CDT)
CC: "Bob_Tracy" <rct@gherkin.sa.wlk.com>, Mircea Damian <dmircea@kappa.ro>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Intriguing its all Cyrix.

That was the first thing that hit me (stood out).

> What compiler, what processor choice in the build.

compiler:
gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)

processor choice:
586/K5/5x86/6x86/6x86MX                CONFIG_M586

> It looks like it is time
> to run 2.4.6ac on my Cyrix MII/233 and take a look.

Any chance this might be an "APIC support on uniprocessor" kind of thing?
I haven't tried disabling that yet to see if it makes any difference,
and it will be several hours before I'll get a chance to try it :-(.

--Bob
