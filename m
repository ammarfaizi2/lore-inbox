Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261321AbTCTIlL>; Thu, 20 Mar 2003 03:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261330AbTCTIlL>; Thu, 20 Mar 2003 03:41:11 -0500
Received: from mail.ithnet.com ([217.64.64.8]:7953 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S261321AbTCTIlK>;
	Thu, 20 Mar 2003 03:41:10 -0500
Date: Thu, 20 Mar 2003 09:51:58 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Wolfram Schlich <wolfram@schlich.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hardlocks with 2.4.21-pre5, pdc202xx_new (PDC20269) and shared
 IRQs
Message-Id: <20030320095158.221cf888.skraw@ithnet.com>
In-Reply-To: <20030320072259.ALLYOURBASEAREBELONGTOUS.E6336@bla.fasel.org>
References: <20030319221608.ALLYOURBASEAREBELONGTOUS.A29767@bla.fasel.org>
	<1048124539.647.18.camel@irongate.swansea.linux.org.uk>
	<20030320072259.ALLYOURBASEAREBELONGTOUS.E6336@bla.fasel.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Mar 2003 08:22:59 +0100
Wolfram Schlich <wolfram@schlich.org> wrote:

> [died ide with shared interrupts]

Don't know if it is related, but I experienced the same thing sharing PDC with
3com GBit (Broadcom) and it was indeed solved by latest version of tg3-driver
from Jeff. Maybe there are analogies between the two cases concerning the nic
drivers, too.

-- 
Regards,
Stephan
