Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbVJDMsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbVJDMsj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 08:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbVJDMsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 08:48:39 -0400
Received: from ozlabs.org ([203.10.76.45]:1474 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932406AbVJDMsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 08:48:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17218.31264.61421.415716@cargo.ozlabs.ibm.com>
Date: Tue, 4 Oct 2005 22:48:32 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Rune Torgersen" <runet@innovsys.com>
Cc: "Marc" <marvin24@gmx.de>, <linuxppc-dev@ozlabs.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: clock skew on B/W G3
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B859476@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B859476@ismail.innsys.innovsys.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rune Torgersen writes:

> CONFIG_HZ is not broken, but the whole clock configuration is.
> (I poseded something about it for 8260 earlier this summer)
> 
> Basic problem is that CLOCK_TICK_RATE which is used for setting up the
> variables used for advancing the clock, is hardcoded to a value that
> only makes sence for an i386. (it is default set at 1193180Hz which
> happens to be the timer clock for timer1 on an i386 machine)

I do not believe CLOCK_TICK_RATE affects timekeeping at all on ppc or
ppc64 machines, but I could be wrong.  Can you show us where and how
CLOCK_TICK_RATE affects things?

Paul.
