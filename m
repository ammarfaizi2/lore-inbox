Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWJNHgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWJNHgQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 03:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbWJNHgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 03:36:16 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:23965 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1751274AbWJNHgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 03:36:15 -0400
Subject: Re: [PATCH] drivers/char/riscom8.c: save_flags()/cli()/sti()
	removal
From: Amol Lad <amol@verismonetworks.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux kernel <linux-kernel@vger.kernel.org>,
       kernel Janitors <kernel-janitors@lists.osdl.org>
In-Reply-To: <1160751657.25218.47.camel@localhost.localdomain>
References: <1160739628.19143.376.camel@amol.verismonetworks.com>
	 <1160751657.25218.47.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 14 Oct 2006 13:09:34 +0530
Message-Id: <1160811574.19143.391.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-13 at 16:00 +0100, Alan Cox wrote:
> Ar Gwe, 2006-10-13 am 17:10 +0530, ysgrifennodd Amol Lad:
> > Removed save_flags()/cli()/sti() and used (light weight) spin locks
> > 
> 
> Have you tested this and verified there are no recursive locking cases
> in your changes ?

I doxygend riscom8.c and used call graphs to verify there are no
recursive locks. I did a code review also

Due to lack of hardware, I was not able to do any runtime checks.

