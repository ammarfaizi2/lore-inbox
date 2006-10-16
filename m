Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161191AbWJPAVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161191AbWJPAVY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 20:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161184AbWJPAVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 20:21:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:58278 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161191AbWJPAVX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 20:21:23 -0400
Date: Mon, 16 Oct 2006 01:21:19 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linus Torvalds <torvalds@osdl.org>, davem@davemloft.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] bnep endianness bug: filtering by packet type
Message-ID: <20061016002119.GD29920@ftp.linux.org.uk>
References: <20061015213125.GU29920@ftp.linux.org.uk> <1160955253.14340.15.camel@localhost> <20061015235148.GZ29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061015235148.GZ29920@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 12:51:48AM +0100, Al Viro wrote:
> On Mon, Oct 16, 2006 at 01:34:13AM +0200, Marcel Holtmann wrote:
> > Hi Al,
> > 
> > > <= and => don't work well on net-endian...
> > 
> > can we have a clean one for the BNEP part. Not one that changes
> > something and then another one reverting it.
> 
> *shrug*
> 
> I can reorder, of course.  FWIW, I prefer to do a patch that annotates
> existing use and provably does not change behaviour + fixes for whatever
> crap shows up once said existing use is annotated, but if you prefer it
> in opposite order...
> 
> OTOH, in this case bug is obvious enough as it is, so...  Will reorder
> and send.

Done.
