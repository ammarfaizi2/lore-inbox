Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271637AbTGQXtv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 19:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271638AbTGQXtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 19:49:51 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:49673 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S271637AbTGQXtu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 19:49:50 -0400
Date: Fri, 18 Jul 2003 02:04:44 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Message-ID: <20030718020444.A2612@pclin040.win.tue.nl>
References: <20030716184609.GA1913@kroah.com> <20030718002451.A2569@pclin040.win.tue.nl> <20030717224307.GF19891@ca-server1.us.oracle.com> <20030718011115.A2600@pclin040.win.tue.nl> <bf7clr$ang$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <bf7clr$ang$1@news.cistron.nl>; from miquels@cistron.nl on Thu, Jul 17, 2003 at 11:49:15PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 11:49:15PM +0000, Miquel van Smoorenburg wrote:

> But why do you need a 32bit interface to the kernel when a
> 32:32 interface exists? Userland can translate 32 bit major/minor
> into 32:32 to the kernel, if a 64 bits syscall exists.

I? A 32bit interface to the kernel? Why do you think I want one?

The discussion has become too long, and people react to single
sentences in a reply instead of reading the thread.

[This started when I answered Andrew and wrote about a dev_t:
8+8 when 16-bit, otherwise 16+16 when 32-bit, otherwise 32+32.
Look: no kernel involved. No interface involved.
This structure is defined by <sys/sysmacros.h>.]

