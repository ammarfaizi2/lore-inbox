Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129329AbRB0Ao1>; Mon, 26 Feb 2001 19:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129350AbRB0AoQ>; Mon, 26 Feb 2001 19:44:16 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:25819 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129329AbRB0AoG>; Mon, 26 Feb 2001 19:44:06 -0500
Message-ID: <3A9AF846.A2A223D@uow.edu.au>
Date: Tue, 27 Feb 2001 00:43:50 +0000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.1-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vibol Hou <vhou@khmer.cc>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Sytem slowdown on 2.4.1-ac20 (recurring from 2.4.0)
In-Reply-To: <NDBBKKONDOBLNCIOPCGHCEOGEPAA.vhou@khmer.cc>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vibol Hou wrote:
> 
> I've reported this problem a long while ago, but no one answered my pleas.
> To tell you the honest truth, I don't know where to begin looking.  It's
> difficult to poke around when the serial console is unresponsive :/
> 

Sounds like a network driver problem.

Are you still getting the "hordes" of Tx timeouts with the
3c905B which you reported a week ago?

If so, do they only start coming out when the slowdown occurs?

You are probably a victim of the APIC bug.  A
workaround for this is present in 2.4.2-ac5.  Alternatively,
boot the kernel with the `noapic' LILO option.

Please let us know the outcome.

-
