Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264256AbUESPzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbUESPzx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 11:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbUESPzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 11:55:53 -0400
Received: from ee.oulu.fi ([130.231.61.23]:50852 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S264256AbUESPzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 11:55:52 -0400
Date: Wed, 19 May 2004 18:55:41 +0300 (EEST)
From: Tuukka Toivonen <tuukkat@ee.oulu.fi>
X-X-Sender: tuukkat@stekt37
To: Ricky Beam <jfbeam@bluetronic.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: overlaping printk
Message-ID: <Pine.GSO.4.58.0405191848430.10266@stekt37>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try transferring large files via minicom/zmodem (lrzsz).
Do you get CRC errors during transfer (would definitely point to serial
driver then).

Similar problems happen to me on my laptop when using 2.2.x with X server
or 2.4.x with or without. 2.2.x without X is fine, haven't tested 2.6.x
yet. (by the way, no problem with serial mouse, just file transfers which
do not proceed since almost all frames have some errors).

I've also ran serial console with 2.6.x on SMP machine with the laptop as
console (but running 2.4.x). Sometimes the output gets slightly garbled,
could be a problem with flow control too. I can do more experiments if
anyone is interested.
