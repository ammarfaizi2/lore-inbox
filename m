Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264528AbTCYUi1>; Tue, 25 Mar 2003 15:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264529AbTCYUi1>; Tue, 25 Mar 2003 15:38:27 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:8463 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264528AbTCYUiY>; Tue, 25 Mar 2003 15:38:24 -0500
Date: Tue, 25 Mar 2003 20:49:30 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Andy Pfiffer <andyp@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL PATCH][2.5.66] fix for link-error in i810fb_imageblit
In-Reply-To: <20030325201815.F24418@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0303252049020.6228-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Why linux/fb.h and why asm/string.h when we have linux/string.h?
> Shouldn't <linux/string.h> be included by the i810fb driver?

Done. I added linux/string.h to i810_accel.c.


