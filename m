Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268059AbTBMP3m>; Thu, 13 Feb 2003 10:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268061AbTBMP3m>; Thu, 13 Feb 2003 10:29:42 -0500
Received: from air-2.osdl.org ([65.172.181.6]:59010 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268059AbTBMP3l>;
	Thu, 13 Feb 2003 10:29:41 -0500
Date: Thu, 13 Feb 2003 09:33:07 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Rusty Lynch <rusty@linux.co.intel.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5.60 Trivial] Sysfs not handling show errors
In-Reply-To: <1045089456.1150.6.camel@vmhack>
Message-ID: <Pine.LNX.4.33.0302130932530.1133-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12 Feb 2003, Rusty Lynch wrote:

> Attempting to cat a sysfs file that returns an error will result in an
> endless dump of garbage to the screen because the result of the specific
> show operation was being saved to a size_t (unsigned) and then later
> checked for a negative value.
> 
> Here is a trivial patch to fix the error.

Thanks, applied.

	-pat

