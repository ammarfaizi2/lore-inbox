Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131481AbRECPpL>; Thu, 3 May 2001 11:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132057AbRECPpD>; Thu, 3 May 2001 11:45:03 -0400
Received: from [63.95.87.168] ([63.95.87.168]:11269 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S131481AbRECPoy>;
	Thu, 3 May 2001 11:44:54 -0400
Date: Thu, 3 May 2001 11:44:52 -0400
From: Gregory Maxwell <greg@linuxpower.cx>
To: Keith Owens <kaos@ocs.com.au>
Cc: Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
Message-ID: <20010503114452.B26337@xi.linuxpower.cx>
In-Reply-To: <80BTbB7Hw-B@khms.westfalen.de> <13656.988875876@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <13656.988875876@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Thu, May 03, 2001 at 05:44:36PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2001 at 05:44:36PM +1000, Keith Owens wrote:
> On 03 May 2001 09:13:00 +0200, 
> kaih@khms.westfalen.de (Kai Henningsen) wrote:
> >pavel@suse.cz (Pavel Machek)  wrote on 30.04.01 in <20010430104231.C3294@bug.ucw.cz>:
> >
> >> PS: Hmm, how do you do timewarp for just one userland appliation with
> >> this installed?
> >
> >1. What on earth for?
> 
> Y10K testing :)
> 
> >2. How do you do it today, and why wouldn't that work?
> 
> LD_PRELOAD on a library that overrides gettimeofday().  I can see no
> reason why that would not continue to work.  What would stop working
> are timewarp modules that intercepted the syscall at the kernel level
> instead of user space level.

It would just have to be done a differnt way.. For those applications you
make a differnt magic page and redirect them there.
