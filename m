Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264089AbTIIM34 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 08:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264100AbTIIM3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 08:29:55 -0400
Received: from gprs146-185.eurotel.cz ([160.218.146.185]:63618 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264089AbTIIM3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 08:29:54 -0400
Date: Tue, 9 Sep 2003 14:29:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Driver model problems in -test5: usb this time
Message-ID: <20030909122938.GA12450@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Upon attempt to swsusp, I get "Unable to handle kernel paging request
at virtual address fffffff4" in usb_device_suspend, called from
suspend_device, device_suspend, drivers_suspend, do_software_suspend,
....

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
