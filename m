Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVAMTUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVAMTUO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 14:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVAMTS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 14:18:58 -0500
Received: from mx02.qsc.de ([213.148.130.14]:15526 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S261329AbVAMTRj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 14:17:39 -0500
Mime-Version: 1.0 (Apple Message framework v619)
In-Reply-To: <20050113185453.GA10195@havoc.gtf.org>
References: <20050113185453.GA10195@havoc.gtf.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <C93FAD39-6597-11D9-BBEE-000393AF911C@exactcode.de>
Content-Transfer-Encoding: 8BIT
From: =?ISO-8859-1?Q?Ren=E9_Rebe?= <rene@exactcode.de>
Subject: Re: gcc randomly crashes on my PowerBook with recent kernels...
Date: Thu, 13 Jan 2005 20:17:37 +0100
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.619)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13. Jan 2005, at 19:54 Uhr, David Eger wrote:

> I apologize for the vagueness of the message, but for all ye TiBook 
> users,
> over the last couple months of kernels, I've noticed gcc (various 
> versions
> in the 3.0 series randomly), non-deterministically crashing on large 
> builds.
>
> The builds tend to be fine and complete immediately after a reboot.
> I've replaced my RAM recently, and the problem happened before and 
> after
> the replacement so I don't *think* it's the RAM.
>
> Has anyone seen this sort of weird corruption behavior?  I don't know
> where or how to start debugging this.  Could be anything... bad 
> drivers,
> bad builds of gcc.. Any ideas?  (and if you suggest d/ling a stock
> compiler, instructions for doing this in gentoo would be appreciated 
> ;-) )

My T2 (www.t2-project.org) PowerPC systems tend to be rock solid - I 
only once managed to get random memory corruption when I tried out 
PREEMPTION. BenH mentioned PREEMPTION and ReiserFS (I use) might not 
play that well - at least not on PowerPC.

I had yet no time to review the affected code myself - however without 
PREEMPTION all is well.

Yours,

-- 
René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
             http://www.exactcode.de | http://www.exactcode.de/t2
             +49 (0)30  255 897 45

