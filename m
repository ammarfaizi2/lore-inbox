Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272706AbRIPT2N>; Sun, 16 Sep 2001 15:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272682AbRIPT2C>; Sun, 16 Sep 2001 15:28:02 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:33138 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S272706AbRIPT1w>; Sun, 16 Sep 2001 15:27:52 -0400
Date: Sun, 16 Sep 2001 15:28:17 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200109161928.f8GJSHb04108@devserv.devel.redhat.com>
To: bahamat@timespace.dhs.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4.x won't boot on sony vaio pcg-fx215
In-Reply-To: <mailman.1000635120.17034.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1000635120.17034.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't have any specifics because with different configs I get different
> errors and I don't know how to get dumps of the errors, but the usual ones are
> along the lines of:

You have to use a serial console in a cese like this.
Only first oops is important, so those who cannot set
up serial console, sometimes add "for(;;) {}" into
die_if_kernel() or thereabouts to halt the machine once
first oops hits the screen.

-- Pete
