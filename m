Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWCLCHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWCLCHF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 21:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWCLCHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 21:07:05 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.7]:50194 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1750826AbWCLCHC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 21:07:02 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: psycho@rift.ath.cx
Subject: Re: PROBLEM: kernel BUG at mm/rmap.c:486 - kernel 2.6.15-r1
Date: Sun, 12 Mar 2006 02:06:53 +0000
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <20060312000621.GA8911@nexon>
In-Reply-To: <20060312000621.GA8911@nexon>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603120206.53683.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 March 2006 00:06, Patrick Börjesson wrote:
> > Just to let you know, I've had the same problem on x86-64. It's an
> > incredibly rare fault here and I've not been able to reproduce it.
> > However, I cannot help but notice that all of the reporters so far
> > have been running the binary NVIDIA driver, including myself.
> >
> > I would not be surprised if running without the NVIDIA driver
> > eliminated the problem.
>
> Not running either with the NVIDIA driver or with x86-64 on the machine
> I'm getting this on, but I get it fairly often (as in: today I've
> probably gotten it at least 5-10 times). It seems it's pretty bound by
> either high CPU or disk usage, since I've always gotten it while
> compiling stuff so far. Although my system doesn't hard lock if I get
> this error; I can at least run most commands and ssh into it.

Please don't do anything! A reproducible test case without NVIDIA loaded is 
exactly what we've been waiting for.

Please search the archives for Hugh Dickins's patch for 2.6.15 which enables 
additional rmap debug. Then try to reproduce the fault.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
