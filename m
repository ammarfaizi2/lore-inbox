Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136727AbRECKiZ>; Thu, 3 May 2001 06:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136708AbRECKiE>; Thu, 3 May 2001 06:38:04 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:4343 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S136727AbRECKhw>; Thu, 3 May 2001 06:37:52 -0400
Date: Thu, 3 May 2001 12:37:50 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
Message-ID: <20010503123749.E754@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <80BTbB7Hw-B@khms.westfalen.de> <13656.988875876@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <13656.988875876@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Thu, May 03, 2001 at 05:44:36PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2001 at 05:44:36PM +1000, Keith Owens wrote:
> >2. How do you do it today, and why wouldn't that work?
> 
> LD_PRELOAD on a library that overrides gettimeofday().  I can see no
> reason why that would not continue to work. 

Static linkage?

> What would stop working
> are timewarp modules that intercepted the syscall at the kernel level
> instead of user space level.

That's what the poster talked about ;-)

Think subterfuge (sp?) and friends.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
