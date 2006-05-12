Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWELFnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWELFnp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 01:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbWELFnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 01:43:45 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:14867 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750922AbWELFnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 01:43:45 -0400
Date: Fri, 12 May 2006 07:43:39 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Joshua Hudson <joshudson@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc4 mucked .config
Message-ID: <20060512054339.GG11191@w.ods.org>
References: <bda6d13a0605112102m70b20772y946d149b6f8bd56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bda6d13a0605112102m70b20772y946d149b6f8bd56@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2006 at 09:02:26PM -0700, Joshua Hudson wrote:
> Imported .config from 2.6.16.1
> ran "make" to prompt for fill in new values
> 
> Found it automatically set on USB storage driver, some sound driver,
> and "Video for Linux".
> Possibly also the parallel port, or maybe that was already on.
> Didn't prompt for any of these
> 
> Noticed after kernel was some 500k larger than expected.

Why did not you do "make oldconfig" in the first place ? This is the
only way to migrate your .config from one kernel to another, as it
will ask questions only for unknown (=new) values.

Willy

