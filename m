Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265864AbTFSRfS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 13:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265865AbTFSRfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 13:35:18 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:39596 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id S265864AbTFSRfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 13:35:12 -0400
Date: Thu, 19 Jun 2003 12:48:49 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Joshua Kwan <joshk@triplehelix.org>
cc: Magnus Solvang <magnus@solvang.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       <kkeil@suse.de>
Subject: Re: isdn compile-errors (Linux 2.5.72)
In-Reply-To: <20030619173019.GA30548@triplehelix.org>
Message-ID: <Pine.LNX.4.44.0306191247210.23441-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jun 2003, Joshua Kwan wrote:

> On Thu, Jun 19, 2003 at 01:48:07PM +0200, Magnus Solvang wrote:
> > drivers/isdn/i4l/isdn_tty.c: In function `isdn_tty_write':
> > drivers/isdn/i4l/isdn_tty.c:1198: warning: unused variable `m'
> *snip*
> > drivers/isdn/i4l/isdn_tty.c: In function `isdn_tty_init':
> > drivers/isdn/i4l/isdn_tty.c:2099: invalid type argument of `->'
> > drivers/isdn/i4l/isdn_tty.c:2101: invalid type argument of `->'
> > drivers/isdn/i4l/isdn_tty.c:2102: invalid type argument of `->'
> *snip*
> > drivers/isdn/i4l/isdn_tty.c: In function `isdn_tty_exit':
> > drivers/isdn/i4l/isdn_tty.c:2121: invalid type argument of `->'
> > drivers/isdn/i4l/isdn_tty.c:2122: invalid type argument of `->'
> > drivers/isdn/i4l/isdn_tty.c:2123: invalid type argument of `->'
> 
> Attached patch should fix these, though I've not tested it.
> (I hope I CC'd the right people.) Should apply against 2.5.72
> vanilla.

I already sent an update which fixes those errors and a couple of other 
bits to Linus. Thanks, though.

--Kai


