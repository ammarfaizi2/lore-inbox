Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264241AbUARWmV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 17:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264245AbUARWmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 17:42:21 -0500
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:34169 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264241AbUARWmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 17:42:20 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH 1/7] i8042 suspend
Date: Sun, 18 Jan 2004 17:42:07 -0500
User-Agent: KMail/1.5.4
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <200401030350.43437.dtor_core@ameritech.net> <200401030356.48071.dtor_core@ameritech.net> <20040118192336.L19593@flint.arm.linux.org.uk>
In-Reply-To: <20040118192336.L19593@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401181742.07878.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 January 2004 02:23 pm, Russell King wrote:
> On Sat, Jan 03, 2004 at 03:56:45AM -0500, Dmitry Torokhov wrote:
> > ===================================================================
> >
> >
> > ChangeSet@1.1571, 2004-01-02 00:22:32-05:00, dtor_core@ameritech.net
> >   Input: Add suspend methods to restore original controller state
> >          on suspend as some BIOS don't like the state we leave it in.
> >          Also synchroniously delete the polling timer on module exit.
> >
> >
> >  i8042.c |   76
> > +++++++++++++++++++++++++++++++++++++++++++++------------------- 1
> > files changed, 54 insertions(+), 22 deletions(-)
>
> Anyone know what the state of this patch is?  I notice that the
> 2.6-merged i8042.c still doesn't disable the polling timer on suspend.

I believe it's in latest -mm and Andrew was going to push it to Linus.

-- 
Dmitry
