Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266373AbUGJUDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266373AbUGJUDo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 16:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266376AbUGJUDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 16:03:44 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:41431 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S266373AbUGJUDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 16:03:43 -0400
Date: Sat, 10 Jul 2004 13:03:35 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
Cc: Andreas Schwab <schwab@suse.de>, Jan Knutar <jk-lkml@sci.fi>,
       L A Walsh <lkml@tlinx.org>, linux-kernel@vger.kernel.org
Subject: Re: XFS: how to NOT null files on fsck?
Message-ID: <20040710200335.GA6095@taniwha.stupidest.org>
References: <200407050247.53743.norberto+linux-kernel@bensa.ath.cx> <200407101555.27278.norberto+linux-kernel@bensa.ath.cx> <je658vwtbl.fsf@sykes.suse.de> <200407101646.27067.norberto+linux-kernel@bensa.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407101646.27067.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2004 at 04:46:27PM -0300, Norberto Bensa wrote:

> Wow. You're telling me that XFS doesn't know if a given piece of the
> log is from file-a or file-b and just in case it zeroes its
> contents?

No.

The log-replay can't tell where that block came from --- it might have
been newly allocated and therfore need zeroing.

> If that's true, XFS has moved to my never-ever-use-it-again list.

There are many alternatives.


   --cw
