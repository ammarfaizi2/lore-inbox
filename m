Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263594AbUJ3AsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263594AbUJ3AsC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 20:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbUJ3AoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 20:44:16 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:61088 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S263617AbUJ3Ak7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 20:40:59 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: [2.6 patch] usbnet.c: remove an unused function
Date: Fri, 29 Oct 2004 17:37:04 -0700
User-Agent: KMail/1.6.2
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
References: <20041028232455.GK3207@stusta.de> <200410291617.30136.david-b@pacbell.net> <20041029232742.GE6677@stusta.de>
In-Reply-To: <20041029232742.GE6677@stusta.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410291737.04415.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 October 2004 16:27, Adrian Bunk wrote:
> On Fri, Oct 29, 2004 at 04:17:30PM -0700, David Brownell wrote:

> > p.s. Last I looked, GCC ignored unused inlines; no code
> >      generated, no warnings.  Did that change?
> >...
> 
> It didn't change.
> 
> But there are three different possible reactions on my patches:
> 1. ACK, kill this dead code
> 2. ups, I really wanted to use this function
> 3. please keep, code using this function will/might follow in the future
> 
> Case 1 is the most common case (and this simply removes some dead code).
> 
> I had until now two times case 2 (which means the code is now better).
> 
> You are the first person for case 3.

And presumably there will also be at least a few case 4:

  4. no response, treated as an ACK.

:)

