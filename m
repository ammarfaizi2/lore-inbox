Return-Path: <linux-kernel-owner+w=401wt.eu-S964831AbXAHVtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbXAHVtK (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 16:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbXAHVtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 16:49:10 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3436 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S964831AbXAHVtJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 16:49:09 -0500
Date: Mon, 8 Jan 2007 22:49:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.37
Message-ID: <20070108214910.GD6167@stusta.de>
References: <200701070337_MC3-1-D79B-2928@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701070337_MC3-1-D79B-2928@compuserve.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2007 at 03:35:21AM -0500, Chuck Ebbert wrote:
> In-Reply-To: <20070104222517.GL20714@stusta.de>
> 
> On Thu, 4 Jan 2007 23:25:17 +0100, Adrian Bunk wrote:
> 
> > There's already a CVE number for
> > "i386: save/restore eflags in context switch".
> > 
> > Are there also CVE numbers for the equivalent x86_64 patch and
> > "x86_64: fix ia32 syscall count"?
> 
> Sorry, my Web access is broken for now so I can't check, but I believe
> that CVE number is for a different, older problem.
> 
> So AFAIK there are no CVE numbers for anything I sent (but there
> probably should be.)  Generic Linux kernel developers don't have
> a CVE representative, so we depend on vendors to assign numbers
> and sometimes they don't.

I asked on vendor-sec and got CVE-2006-5755 for the x86_64 equivalent of 
CVE-2006-5173, but none for the syscall count issue.

The latter is IMHO OK since "local user can spam syslog" is really 
borderline - there are simply too many DoS possibilities for local 
users.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

