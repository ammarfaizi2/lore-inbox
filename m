Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317986AbSHZJEa>; Mon, 26 Aug 2002 05:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318013AbSHZJEa>; Mon, 26 Aug 2002 05:04:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24080 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317986AbSHZJE3>; Mon, 26 Aug 2002 05:04:29 -0400
Date: Mon, 26 Aug 2002 10:08:44 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "James H. Cloos Jr." <cloos@jhcloos.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre4-ac1 patch error and compile error
Message-ID: <20020826100844.B900@flint.arm.linux.org.uk>
References: <m3ptw6jky2.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m3ptw6jky2.fsf@lugabout.jhcloos.org>; from cloos@jhcloos.com on Mon, Aug 26, 2002 at 12:36:05AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 12:36:05AM -0400, James H. Cloos Jr. wrote:
> The last few ac patches have, when patched to a clone of
> bk://linux.bkbits.net/linux-2.4 limited to the appropriate cset, had
> rejects from drivers/scsi/sim710_d.h.  patch(1) indicates a previously
> applied patch.
> 
> arch/i386/kernel/time.c failed to compile.  Based on the error, the
> required patch is:

You still want time.o to be listed in obj-y for it to be built.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

