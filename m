Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268291AbUGXFP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268291AbUGXFP4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 01:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268292AbUGXFP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 01:15:56 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:44466 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S268291AbUGXFPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 01:15:55 -0400
Date: Fri, 23 Jul 2004 22:15:50 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Robert Love <rml@ximian.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel events layer
Message-ID: <20040724051550.GA30718@taniwha.stupidest.org>
References: <1090604517.13415.0.camel@lucy> <20040723200335.521fe42a.akpm@osdl.org> <1090635297.1830.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090635297.1830.4.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2004 at 10:14:57PM -0400, Robert Love wrote:

> Predicting the future is hard, but I suspect this number to be
> small.  Let's say 10 in core kernel code?

Seems fair.

> If this takes off as a solution for error reporting, that number
> will be much larger in drivers.

This part worries me a lot.  I would alsmost rather all possible
messages get stuck somewhere common so driver writes can't add these
ad-hoc and we can avoid a proliferation of either similar or pointless
messages.

Forcing these into a common place lets people eyeball if a new
messages really is necessary --- and it makes writing applications to
deal with these things easier (since you don't have to scan the entire
kernel tree).



    --cw
