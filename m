Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266624AbUFYKA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266624AbUFYKA4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 06:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266687AbUFYKA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 06:00:56 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:16132 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S266624AbUFYKAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 06:00:54 -0400
Date: Fri, 25 Jun 2004 12:00:52 +0200
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-mm2, mmaps rework, buggy apps, setarch
Message-ID: <20040625100051.GA19905@gamma.logic.tuwien.ac.at>
References: <20040625082243.GA11515@gamma.logic.tuwien.ac.at> <1088152275.2704.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1088152275.2704.8.camel@laptop.fenrus.com>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arjan!

On Fre, 25 Jun 2004, Arjan van de Ven wrote:
> > Can someone please explain me *what* the effects of a `buggy app' would
> > be: Segfault I suppose. But what to do with a commerical app where I
> > cannot check a stack trace or whatever?
> 
> basically the applications that break do:
> 
> int ptr;
> ptr = malloc(some_size);
> if (ptr <= 0) 
>     handle_no_memory();

Mmm, this looks very common. What is the `intended' way to handle this?

> > Background: I am having problems with current debian/sid on 2.6.7-mm2
> > with vuescan.
> 
> can you describe these problems in somewhat more detail ?

vuescan works on 2.6.7 and dumps core on 2.6.7-mm2 when doing memory
intense stuff like scanning, previewing or some other things.

I will try the setarch prog from Andrew after I have rebooted into mm2
(ATM scanning is in process).

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
HULL (adj.)
Descriptive of the smell of a weekend cottage.
			--- Douglas Adams, The Meaning of Liff
