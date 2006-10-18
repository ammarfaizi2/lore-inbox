Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161241AbWJRRnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161241AbWJRRnA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161231AbWJRRnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:43:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43423 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751486AbWJRRm7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:42:59 -0400
Date: Wed, 18 Oct 2006 18:42:57 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
Message-ID: <20061018174257.GP29920@ftp.linux.org.uk>
References: <20061017005025.GF29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610161847210.3962@g5.osdl.org> <20061017043726.GG29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610170821580.3962@g5.osdl.org> <20061018044054.GH29920@ftp.linux.org.uk> <20061018091944.GA5343@martell.zuzino.mipt.ru> <20061018093126.GM29920@ftp.linux.org.uk> <20061018100057.GB5343@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018100057.GB5343@martell.zuzino.mipt.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 02:00:57PM +0400, Alexey Dobriyan wrote:
> > 	Anyway, that patch is obviously preliminary - at the very least
> > it needs be checked on more configs (and more targets - e.g. mips and
> > parisc hadn't been checked at all).
> 
> configs. Is ftp://ftp.linux.org.uk/pub/people/viro/config/ still
> relevant?

Updated.  Changes since the last time:
	ARCH=ppc targets dropped
	a couple of weird ones (sun3 and sun4 ;-) added
	drift in Kconfig required more explicit option disabling in some
cases
