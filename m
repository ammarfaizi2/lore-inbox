Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265820AbUFOSW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265820AbUFOSW3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 14:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265815AbUFOSVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 14:21:19 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:23425 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S265820AbUFOSUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 14:20:45 -0400
Date: Tue, 15 Jun 2004 11:20:39 -0700
From: Chris Wedgwood <cw@f00f.org>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] stat nlink resolution fix
Message-ID: <20040615182039.GA4553@taniwha.stupidest.org>
References: <20040615055507.GA9847@taniwha.stupidest.org> <20040615145624.GC20432@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615145624.GC20432@wohnheim.fh-wedel.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 04:56:25PM +0200, J?rn Engel wrote:

> Just for me to get a clue, what would break if the definition of
> nlink_t changed?

It's derived from __kernel_nlink_t which is exported to userspace
(well, glibc headers).


  --cw
