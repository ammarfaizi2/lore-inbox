Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264164AbUE2OHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264164AbUE2OHl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 10:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbUE2OHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 10:07:41 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:10513 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S264164AbUE2OHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 10:07:40 -0400
Date: Sat, 29 May 2004 16:07:36 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: keyboard problem with 2.6.6
Message-ID: <20040529140736.GD5175@pclin040.win.tue.nl>
References: <20040528154307.142b7abf.akpm@osdl.org> <20040529070953.GB850@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040529070953.GB850@ucw.cz>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : kweetal.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2004 at 09:09:53AM +0200, Vojtech Pavlik wrote:

> One more thought: The emulated PS/2 mouse so many people are complaining
> about is there only because applications like X cannot use the native
> event interface. It was intended to be removed after that support is
> added, but with X development being as slow as it is, it didn't ever
> happen.

A mistake.

You add new functionality. That is good. At the same time you want
to force people to use this new stuff by throwing out the old. Bad.

It is almost impossible to remove features from the kernel.
People have a great variety of user space setups, and can have
lots of reasons why it is undesirable or impossible to change
their software, while a new kernel may be required to support
new hardware or for security reasons.

One should always (i) go in a long series of tiny steps,
(ii) attempt to be 100% backwards compatible.
Obsoleting old stuff is done over a period of more than
five years, if at all.

Andries
