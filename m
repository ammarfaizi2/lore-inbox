Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbUCAEOn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 23:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbUCAEOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 23:14:43 -0500
Received: from H38.C133.B246.tor.eicat.ca ([66.246.133.38]:65463 "EHLO
	221.1.151.209.achilles.net") by vger.kernel.org with ESMTP
	id S262242AbUCAEOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 23:14:43 -0500
Date: Sun, 29 Feb 2004 23:12:37 -0500
From: Benjamin LaHaise <bcrl@achilles.net>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: couple of oopses in 2.6.3-gentoo
Message-ID: <20040301041237.GA23926@achilles.net>
References: <404295E7.8010501@tequila.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404295E7.8010501@tequila.co.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2004 at 10:46:15AM +0900, Clemens Schwaighofer wrote:
> I just checked my dmesg, actually because I wanted to know if he
> recognices my usb hd, and then I saw these ... I have actually no idead
> whith wich they are connected.

The backtraces indicate that the nvidia driver is calling various kernel 
functions with interrupts disabled.  Pass this report onto your driver 
vendor and berate them appropriately.

		-ben
