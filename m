Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751717AbWD0V74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbWD0V74 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 17:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbWD0V74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 17:59:56 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:8102 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751719AbWD0V7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 17:59:55 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Roman Kononov <kononov195-far@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: C++ pushback
Date: Fri, 28 Apr 2006 07:59:51 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <o6f252lfqhtif2orr0kfmj3fbed0g32djg@4ax.com>
References: <4024F493-F668-4F03-9EB7-B334F312A558@iomega.com> <e2qqrm$1e7$1@sea.gmane.org>
In-Reply-To: <e2qqrm$1e7$1@sea.gmane.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Apr 2006 11:17:58 -0500, Roman Kononov <kononov195-far@yahoo.com> wrote:

>Please let me summarize:
>	1) Many people are more efficient writing C++ modules.
>	2) It does not make sense to rewrite existing C code in
>	   another language.
>	3) Kernel H-files are not compilable by g++.
>	4) The H-files use C++ keywords.
>	5) The H-files use member initialization syntax, unsupported
>	   by g++.
>	6) The H-files use empty structures which are not empty in
>	   g++.
>
>4), 5) and 6) are to be fixed if we want to be g++-friendly. I am not 
>aware of any other issues. Features like static constructors and 
>exceptions are not strictly necessary for successful C++ programming.
>
>4) must be trivial.
>5) is less trivial but still doable. Can we ask g++ folks?
>6) looks rather painful.
>
>What do you think?

There's a document: CodingStyle

You seem to be arguing where the kernelspace / userspace boundary 
line is.  C++ is outside kernelspace.

Grant.
