Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbVGPAkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbVGPAkF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 20:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbVGPAkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 20:40:05 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:9862 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S262019AbVGPAkD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 20:40:03 -0400
X-ORBL: [63.202.173.158]
Date: Fri, 15 Jul 2005 17:39:52 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jan Blunck <j.blunck@tu-harburg.de>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ramfs: pretend dirent sizes
Message-ID: <20050716003952.GA30019@taniwha.stupidest.org>
References: <42D72705.8010306@tu-harburg.de> <Pine.LNX.4.58.0507151151360.19183@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507151151360.19183@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 11:52:42AM -0700, Linus Torvalds wrote:

> I really think you should update the "simple_xxx()" functions
> instead, and thus make this happen for _any_ filesystem that uses
> the simple fs helper functions.

Why bother at all?

I don't see why zero sizes are a problem.  We've had them for year
without complaints.
