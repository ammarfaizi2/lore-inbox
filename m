Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264252AbTEOVUN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 17:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264253AbTEOVUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 17:20:13 -0400
Received: from colossus.systems.pipex.net ([62.241.160.73]:973 "HELO
	colossus.systems.pipex.net") by vger.kernel.org with SMTP
	id S264252AbTEOVUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 17:20:12 -0400
From: shaheed <srhaque@iee.org>
To: Robert Love <rml@tech9.net>
Subject: Re: 2.6 must-fix list, v2
Date: Thu, 15 May 2003 22:30:20 +0100
User-Agent: KMail/1.5
Cc: Felipe Alfaro Solana <yo@felipe-alfaro.com>,
       Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>
References: <1050146434.3e97f68300fff@netmail.pipex.net> <200305152107.17419.srhaque@iee.org> <1053030280.899.27.camel@icbm>
In-Reply-To: <1053030280.899.27.camel@icbm>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305152230.20794.srhaque@iee.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 May 2003 9:24 pm, Robert Love wrote:

> Oh, one other problem with doing it in the kernel via INIT_TASK:
>
> You end up affining any kernel threads, which you absolutely do not want
> to do _implicitly_. Maybe explicitly, but certainly not implicitly as a
> blind consequence.
>
> Doing it via init is really the way to go.

OK, that does make sense.

>Submit a patch to the init maintainer to have it bind itself on boot to
>a given command line value. Maybe I will do this if I find the time...

I will have a go myself too...

[srhaque@chiswick srhaque]$ rpm -q --whatprovides /sbin/init
SysVinit-2.84-2mdk

and rpmfind.net points to ftp://ftp.cistron.nl/pub/people/miquels/software. 
I'll drop you a line if I make progress.

Thanks, Shaheed

