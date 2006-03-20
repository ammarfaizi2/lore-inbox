Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWCTI5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWCTI5E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 03:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWCTI5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 03:57:03 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47292 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932257AbWCTI5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 03:57:00 -0500
Date: Mon, 20 Mar 2006 09:04:39 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, ast@domdv.de
Subject: Announcing crypto suspend
Message-ID: <20060320080439.GA4653@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Thanks to Rafael's great work, we now have working encrypted suspend
and resume. You'll need recent -mm kernel, and code from
suspend.sf.net. Due to its use of RSA, you'll only need to enter
password during resume.

[Code got some minimal review; if you are a crypto expert, and think
you can poke a hole within it, please try to do so.]

								Pavel
-- 
205:class M4PStream
