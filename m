Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137204AbREKStS>; Fri, 11 May 2001 14:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137207AbREKStI>; Fri, 11 May 2001 14:49:08 -0400
Received: from adsl-64-168-227-89.dsl.sntc01.pacbell.net ([64.168.227.89]:28682
	"EHLO brian-laptop.dyn.us.mvd") by vger.kernel.org with ESMTP
	id <S137204AbREKStB>; Fri, 11 May 2001 14:49:01 -0400
Date: Fri, 11 May 2001 11:49:09 -0700
From: "Brian J. Murrell" <brian@mountainviewdata.com>
To: linux-kernel@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] ip autoconfig with modules, kernel 2.4
Message-ID: <20010511114909.B27378@brian-laptop.us.mvd>
In-Reply-To: <20010510094953.C28095@brian-laptop.us.mvd> <20010510180039.D9771@flint.arm.linux.org.uk> <20010511111300.A27378@brian-laptop.us.mvd> <20010511193833.B12798@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010511193833.B12798@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Fri, May 11, 2001 at 07:38:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2001 at 07:38:33PM +0100, Russell King wrote:
> 
> As long as you can get the root server IP and path from the DHCP client,

I can do that.  :-)

> then you mount it in a directory, and use pivot_root() to change to
> that directory.

Cool.

> See the "Changing the root device" of Documentation/initrd.txt for more
> information about this.

This looks like the ticket.  I will hack away at that when I can get a
moment.  :-)

Thanx!

b.

