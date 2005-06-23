Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262695AbVFWVxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbVFWVxU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 17:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262732AbVFWVuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 17:50:40 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:16563 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262717AbVFWVpW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 17:45:22 -0400
Subject: Re: Possible spin-problem in nanosleep()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-os@analogic.com
Cc: Andreas Schwab <schwab@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0506231058560.16531@chaos.analogic.com>
References: <Pine.LNX.4.61.0506230812160.15775@chaos.analogic.com>
	 <jell516ymn.fsf@sykes.suse.de>
	 <Pine.LNX.4.61.0506230841390.15910@chaos.analogic.com>
	 <Pine.LNX.4.61.0506231058560.16531@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119546715.17066.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 23 Jun 2005 22:42:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For most platforms the scheduler measured busy/idle time is from the
timer tick. That means its sampled so you are limited to accurate
information on sleep/wake changes occuring at 1/2 the clock rate or
less.

Alan

