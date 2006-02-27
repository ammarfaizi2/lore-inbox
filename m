Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751698AbWB0VEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbWB0VEi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 16:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbWB0VEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 16:04:38 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:49069 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751181AbWB0VEh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 16:04:37 -0500
Date: Mon, 27 Feb 2006 21:04:27 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <gregkh@suse.de>, Benjamin LaHaise <bcrl@kvack.org>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com, perex@suse.cz,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060227210427.GU27946@ftp.linux.org.uk>
References: <20060227190150.GA9121@kroah.com> <20060227193654.GA12788@kvack.org> <20060227194623.GC9991@suse.de> <Pine.LNX.4.64.0602271216340.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602271216340.22647@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 12:20:49PM -0800, Linus Torvalds wrote:
> They seem to be just excuses for bad habits. And the notion of a "private" 
> interface is insane anyway, since it doesn't matter - the only thing that 
> matters is whether it breaks existing binaries or not, and being "private" 
> in no way makes any difference to that. If you need to compile or link 
> against a new library, it's broken - whether it was "private" or not makes 
> no difference.

gregkh is being polite - s/private/but-we-are-special/ and it will make
more sense...
