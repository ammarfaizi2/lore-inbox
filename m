Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129983AbRAKO7i>; Thu, 11 Jan 2001 09:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132195AbRAKO7T>; Thu, 11 Jan 2001 09:59:19 -0500
Received: from eliot.thebog.net ([209.220.238.57]:40464 "EHLO mail.thebog.net")
	by vger.kernel.org with ESMTP id <S129983AbRAKO7F>;
	Thu, 11 Jan 2001 09:59:05 -0500
Date: Thu, 11 Jan 2001 09:58:53 -0500
To: Robert Lowery <cangela@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI lockup on boot in 2.4.0
Message-ID: <20010111095853.A4442@eliot.thebog.net>
In-Reply-To: <001801c07bc4$e95ee250$0201a8c0@vaio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <001801c07bc4$e95ee250$0201a8c0@vaio>; from cangela@bigpond.net.au on Thu, Jan 11, 2001 at 10:51:59PM +1100
From: Nathan Thompson <nate@thebog.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2001 at 10:51:59PM +1100, Robert Lowery wrote:
 
> I compiled it with ACPI compiled as a module and APM not compiled in at all, but on booting I get the following.
> ACPI: System description tables found
> ACPI: System description tables loaded
> 
> and then the system locks up..

I have a Sony Vaio PCG-F350 that behaves the same way.  I compiled in
ACPI (not a module) and never got further than this.  When I enabled APM
and disabled ACPI everything started to work.

Kernel 2.4.0
gcc: 2.95.2 (I bieleve).

on Debian Potato

Nate
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
