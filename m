Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbVBBI1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbVBBI1O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 03:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbVBBI1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 03:27:14 -0500
Received: from thunk.org ([69.25.196.29]:5802 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262082AbVBBI1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 03:27:11 -0500
Date: Wed, 2 Feb 2005 03:26:43 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Peter Busser <busser@m-privacy.de>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack pointer)
Message-ID: <20050202082643.GA6172@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Peter Busser <busser@m-privacy.de>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org
References: <200501311015.20964.arjan@infradead.org> <200501311357.59630.busser@m-privacy.de> <1107189699.4221.124.camel@laptopd505.fenrus.org> <200502011044.39259.busser@m-privacy.de> <20050202001549.GA17689@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202001549.GA17689@thunk.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2005 at 07:15:49PM -0500, Theodore Ts'o wrote:
> Umm, so exactly how many applications use multithreading (or otherwise
> trigger the GLIBC mprotect call), 

For the record, I've been informed that the glibc mprotect() call
doesn't happen in any modern glibc's; there may have been one buggy
glibc that was released very briefly before it was fixed in the next
release.  But if that's what the paxtest developers are hanging their
hat on, it seems awfully lame to me.....

"desabotaged" seems like the correct description from my vantage
point.

						- Ted
