Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbTKWWey (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 17:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbTKWWey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 17:34:54 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5381 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263510AbTKWWew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 17:34:52 -0500
Date: Sun, 23 Nov 2003 22:34:43 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: Fix locking in input
Message-ID: <20031123223443.A560@flint.arm.linux.org.uk>
Mail-Followup-To: Manfred Spraul <manfred@colorfullife.com>,
	Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@suse.cz>,
	linux-kernel@vger.kernel.org
References: <3FC13382.3060701@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FC13382.3060701@colorfullife.com>; from manfred@colorfullife.com on Sun, Nov 23, 2003 at 11:24:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 23, 2003 at 11:24:02PM +0100, Manfred Spraul wrote:
> I think one platform (early ARM?) cannot access bytes directly, and 
> implement the access with read 16-bit, change 8-bit, write back 16 bit. 

Nope.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
