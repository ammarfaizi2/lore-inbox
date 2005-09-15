Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965287AbVIOWTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965287AbVIOWTP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 18:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965289AbVIOWTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 18:19:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:15020 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965287AbVIOWTO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 18:19:14 -0400
Date: Thu, 15 Sep 2005 23:19:14 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] epca iomem annotations + several missing readw()
Message-ID: <20050915221914.GD19626@ftp.linux.org.uk>
References: <20050915192704.GC25261@ZenIV.linux.org.uk> <20050915231014.C26124@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050915231014.C26124@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 11:10:14PM +0100, Russell King wrote:
> On Thu, Sep 15, 2005 at 08:27:04PM +0100, Al Viro wrote:
> > [originally sent to Alan, he had no problems with it]
> > 	* iomem pointers marked as such
> > 	* several direct dereferencings of such pointers replaced with
> > read[bw]().
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> Thanks for copying me, but I have no interest in any serial driver
> which doesn't use the serial core interface.
> 
> I don't want to act as "person to review any change just because the
> driver says serial" - that's not the role I decided to get involved
> with.

Hey, seeing the intensity of your complaints about _not_ being Cc'd...
Better safe than serial maintainer ;-)

	OK, so what stuff do you want to be Cc'd on?  My current approximation
would be arch/arm/*, include/asm-arm/*,drivers/serial/*,include/linux/serial*.
Well, and any changes of tty interfaces, if I ever get involved in such...
Any additions/removals?
