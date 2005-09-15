Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932597AbVIOWKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbVIOWKW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 18:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbVIOWKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 18:10:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7185 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932597AbVIOWKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 18:10:21 -0400
Date: Thu, 15 Sep 2005 23:10:14 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] epca iomem annotations + several missing readw()
Message-ID: <20050915231014.C26124@flint.arm.linux.org.uk>
Mail-Followup-To: Al Viro <viro@ZenIV.linux.org.uk>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <20050915192704.GC25261@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050915192704.GC25261@ZenIV.linux.org.uk>; from viro@ZenIV.linux.org.uk on Thu, Sep 15, 2005 at 08:27:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 08:27:04PM +0100, Al Viro wrote:
> [originally sent to Alan, he had no problems with it]
> 	* iomem pointers marked as such
> 	* several direct dereferencings of such pointers replaced with
> read[bw]().
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Thanks for copying me, but I have no interest in any serial driver
which doesn't use the serial core interface.

I don't want to act as "person to review any change just because the
driver says serial" - that's not the role I decided to get involved
with.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
