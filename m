Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270429AbTGUQUX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 12:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270440AbTGUQUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 12:20:23 -0400
Received: from athmta04.forthnet.gr ([193.92.150.25]:5732 "EHLO forthnet.gr")
	by vger.kernel.org with ESMTP id S270429AbTGUQUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 12:20:20 -0400
Date: Mon, 21 Jul 2003 19:35:17 +0300
From: michaelm <admin@www0.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1 won't go further than "uncompressing" on a p1/32MB pc
Message-ID: <20030721163517.GA597@www0.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

.config: http://www0.org/config

That is on a p1 150MMX 32MB PC, specifically an IBM ThinkPad 560E. It
will keep showing "booting the kernel, uncompressing" without going
any further. There will be some disk activity for at least 5-7 minutes
after that on a 5-10 seconds interval period, without change on the
screen. I tried removing framebuffer support or keep it but set
CONFIG_VIDEO_SELECT to 'n', but there is still the same output.

The bzimage is around 919Kb, I tried to make it as modular and small
as it gets to be "usefull" since I suspect this is too old to run 2.5,
but the bzimage still can't be less than 800-810 kilobytes.

-michael
