Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270233AbUJTDLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270233AbUJTDLO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 23:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270278AbUJTDFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 23:05:01 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:11106 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S270405AbUJTCqP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 22:46:15 -0400
Subject: Re: Bug?: 2.6.9-bk3
From: Paul Fulghum <paulkf@microgate.com>
To: "Steven E. Woolard" <tuxq@tuxq.com>
Cc: linux-serial@vger.kernel.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       rmk@flint.arm.linux.org.uk
In-Reply-To: <4175C484.5070009@tuxq.com>
References: <4175C484.5070009@tuxq.com>
Content-Type: text/plain
Message-Id: <1098240366.5963.21.camel@at2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 19 Oct 2004 21:46:06 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-19 at 20:51, Steven E. Woolard wrote:
> I ran into this problem when trying to compile 2.6.9-bk3 (since it came 
> out less than 24 hours after 2.6.9 ... bad omen eh?)
> I've attached my .config used just incase it helps. (New to bug 
> reporting...)
> ...
>    CC      drivers/serial/8250.o
> drivers/serial/8250.c:185: error: `UART_FCR_R_TRIG_10' undeclared here 
> (not in a function)

Russell's patch introduces the use of
the UART_FCR_x_TRIG_xx macros, but not
the definition.

-- 
Paul Fulghum
paulkf@microgate.com


