Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265508AbUF2G4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265508AbUF2G4H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 02:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265509AbUF2G4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 02:56:07 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:20620 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265508AbUF2G4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 02:56:04 -0400
Message-ID: <40E1127C.3010509@yahoo.com.au>
Date: Tue, 29 Jun 2004 16:55:56 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Ed Sweetman <safemode@comcast.net>
CC: Peter Williams <pwil3058@bigpond.net.au>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Con Kolivas <kernel@kolivas.org>, Michael Buesch <mbuesch@freenet.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Willy Tarreau <willy@w.ods.org>
Subject: Re: [PATCH] Staircase scheduler v7.4
References: <200406251840.46577.mbuesch@freenet.de> <200406261929.35950.mbuesch@freenet.de> <1088363821.1698.1.camel@teapot.felipe-alfaro.com> <200406272128.57367.mbuesch@freenet.de> <1088373352.1691.1.camel@teapot.felipe-alfaro.com> <Pine.LNX.4.58.0406281013590.11399@kolivas.org> <1088412045.1694.3.camel@teapot.felipe-alfaro.com> <40DFDBB2.7010800@yahoo.com.au> <40E0A7FC.3030200@bigpond.net.au> <40E0F3B1.2030906@yahoo.com.au> <40E1059F.7020105@comcast.net>
In-Reply-To: <40E1059F.7020105@comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman wrote:

> 
> I've seen different audio players react very differently in the same 
> situations with the same kernel.  Are people testing alternatives to 
> make sure it's not just the program being bad?  Maybe the people doing 
> these scheduler tests are using all the popular media players and 
> different widely available gui systems to make sure they're not tuning 
> the kernel for a specific program.   That should probably be clarified.
> I think it ought to be made clear that the gain is being made for a type 
> of program, and not a single one, a type of workload and not a workload 
> consisting of this and that and this program.  That can include 
> different windowing systems (xfree86 vs non-free X implimentations or 
> DirectFB) and gtk vs qt vs no toolkit..  This way obvious userspace bugs 
> can be exposed and all this tuning wont be done for helping keep bugs 
> and bad implimentations in use.
> 

Unfortunately, the number of apps is far too large for one person
to hope to give decent coverage here, let alone all the *combinations*
that people use.

We simply have to rely on testers to report problems. Of course I
do run my own changes on my desktop, and I have a selection of things
to test that have been reported to cause problems in the past...

It would be an idea to set up some regression test machines somewhere
for this sort of thing though. Unfortunately I don't have the
resources.
