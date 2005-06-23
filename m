Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262849AbVFWWMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262849AbVFWWMj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 18:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbVFWWI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 18:08:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64999 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262816AbVFWWGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 18:06:17 -0400
Date: Thu, 23 Jun 2005 15:08:08 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: David Lang <david.lang@digitalinsight.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev List <netdev@vger.kernel.org>
Subject: Re: [git patch] urgent e1000 fix
In-Reply-To: <42BB2749.1020209@pobox.com>
Message-ID: <Pine.LNX.4.58.0506231506510.11175@ppc970.osdl.org>
References: <42BA7FB5.5020804@pobox.com> <Pine.LNX.4.62.0506231402340.18154@qynat.qvtvafvgr.pbz>
 <42BB2749.1020209@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Jun 2005, Jeff Garzik wrote:
> 
> It's probably the whitespace thing that Linus's git-apply gadget was 
> complaining about.
> 
> I'm terribly surprising, though, since my patch(1) applied the diff just 
> fine.

I could easily make git-apply accept empty lines as if they had a single 
space on it. What I find surprising is that "patch" allows that kind of 
whitespace corruption by default, and silently. Usually you have to give 
it the "-l" flag to make it ignore whitespace differences..

		Linus
