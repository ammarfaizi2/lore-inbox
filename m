Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTFJUJa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbTFJUGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 16:06:00 -0400
Received: from werbeagentur-aufwind.com ([217.160.128.76]:46570 "EHLO
	mail.werbeagentur-aufwind.com") by vger.kernel.org with ESMTP
	id S262323AbTFJUFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 16:05:30 -0400
Subject: Re: 2.5.70-mm7
From: Christophe Saout <christophe@saout.de>
To: Konstantin Kletschke <konsti@ludenkalle.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030610200021.GA25654@sexmachine.doom>
References: <20030610004512.6358fdfb.akpm@digeo.com>
	 <20030610200021.GA25654@sexmachine.doom>
Content-Type: text/plain
Message-Id: <1055276348.15946.1.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 10 Jun 2003 22:19:08 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Die, 2003-06-10 um 22.00 schrieb Konstantin Kletschke:

> Well, is the device-mapper module dm-mod not komptaibel anymore with my
> device-mapper 0.96.08 ?
> I did not get it to mount the LVM LVGs and device-mapper was very angry!
> But I am not able to get the error message ATM, something with "function
> not supportet, 2 " or so...

I got the same here. Backed out the device-mapper patches Joe Thornber
posted here, and now it works.

It looks like a problem with the cleanups, at least I didn't see any
ioctl interface change?

-- 
Christophe Saout <christophe@saout.de>

