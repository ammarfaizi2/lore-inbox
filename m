Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314548AbSGLIeB>; Fri, 12 Jul 2002 04:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314553AbSGLIeA>; Fri, 12 Jul 2002 04:34:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12807 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314548AbSGLIeA>; Fri, 12 Jul 2002 04:34:00 -0400
Date: Fri, 12 Jul 2002 09:36:45 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Nick Bellinger <nickb@attheoffice.org>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.25 - Fix USER_HZ breakage on non-x86 archs
Message-ID: <20020712093645.B8850@flint.arm.linux.org.uk>
References: <1026446514.7171.99.camel@subjeKt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1026446514.7171.99.camel@subjeKt>; from nickb@attheoffice.org on Thu, Jul 11, 2002 at 10:01:41PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2002 at 10:01:41PM -0600, Nick Bellinger wrote:
> 	The following patch adds the deprecated USER_HZ definition that was
> added in 2.5.25 to include/linux/times.h for the new
> jiffies_to_clock_t() macro and that is currently defined in
> include/asm/param.h for i386/ppc. All architectures aside from x86 and
> ppc are currently broken without USER_HZ definied and I assume we only
> want a different internal kernel timer frequency for x86 right now, so
> all definitions of USER_HZ in non asm-x86 param.h are set to the
> predefined value of HZ.  

Please drop the ARM section of this patch; updates are pending Linus
pulling from my BK repository.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

