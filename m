Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136857AbREJRBO>; Thu, 10 May 2001 13:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136859AbREJRBE>; Thu, 10 May 2001 13:01:04 -0400
Received: from www.linux.org.uk ([195.92.249.252]:57617 "EHLO www.linux.org.uk")
	by vger.kernel.org with ESMTP id <S136857AbREJRAv>;
	Thu, 10 May 2001 13:00:51 -0400
Date: Thu, 10 May 2001 18:00:39 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Brian J. Murrell" <brian@mountainviewdata.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ip autoconfig with modules, kernel 2.4
Message-ID: <20010510180039.D9771@flint.arm.linux.org.uk>
In-Reply-To: <20010510094953.C28095@brian-laptop.us.mvd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010510094953.C28095@brian-laptop.us.mvd>; from brian@mountainviewdata.com on Thu, May 10, 2001 at 09:49:53AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2001 at 09:49:53AM -0700, Brian J. Murrell wrote:
> Of course, this elminates the need to build kernels with lots of
> statically linked ethernet drivers or building lots of kernels with
> specific drivers statically linked in.
> 
> My hope is that this is seen as a good idea (and a good
> implementation) and that the patch is accepted into the Linux kernel.

Hmm, if you've got userspace up and running, and loaded kernel
modules using insmod, then what's wrong about running a dhcp,
bootp or rarp client from userspace?  You can then drop the
kernel space IP autoconfiguration code.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

