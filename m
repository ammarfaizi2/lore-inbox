Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWAFADZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWAFADZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752308AbWAFADG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:03:06 -0500
Received: from digitalimplant.org ([64.62.235.95]:64929 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S1751708AbWAFACw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:02:52 -0500
Date: Thu, 5 Jan 2006 16:02:29 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Preece Scott-PREECE <scott.preece@motorola.com>
cc: Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>,
       "" <akpm@osdl.org>, "" <linux-pm@lists.osdl.org>,
       "" <linux-kernel@vger.kernel.org>
Subject: RE: [linux-pm] [patch] pm: fix runtime powermanagement's /sys
 interface
In-Reply-To: <ADE4D9DBCFC3A345AAA95C195F62B6DDD3AD5D@de01exm64.ds.mot.com>
Message-ID: <Pine.LNX.4.50.0601051558100.10428-100000@monsoon.he.net>
References: <ADE4D9DBCFC3A345AAA95C195F62B6DDD3AD5D@de01exm64.ds.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 5 Jan 2006, Preece Scott-PREECE wrote:

> This is, of course, in an embedded framework rather than a desktop
> framework - we suspend and wakeup automatically, not via user
> intervention. Answering a question asked in another piece of mail, we
> have roughly a dozen different devices that cause the system to wakeup -
> keypad press, touchscreen touch, flip open/close, etc.

Hmm, it would be nice if that comment was in reply to the email in which
it came. At least if it was in the same thread..

Many systems have > 1 _possible_ wakeup devices (keyboard, touchscreen,
lid, etc). You implied that when a system wakes up, there could be > 1
device that actually woke the system up, which is in direct conflict with
what I've always assumed - that when a system wakes up, it is caused by a
single device (and if there were multiple events, like a key press *and* a
mouse movement, it's doesn't really matter)..

Thanks,


	Patrick

