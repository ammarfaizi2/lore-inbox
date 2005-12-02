Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932572AbVLBAIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbVLBAIs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 19:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbVLBAIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 19:08:48 -0500
Received: from hera.cwi.nl ([192.16.191.8]:28130 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S932575AbVLBAIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 19:08:47 -0500
Date: Fri, 2 Dec 2005 01:08:46 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: security / kbd
Message-ID: <20051202000843.GA18219@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently I muttered a little bit about the fact that everybody who
can mount filesystems using an "auto" fstab filesystem type entry
(or using e.g. an "ext2" entry) can crash the system.
But nobody on lk seems impressed.
Of course, one can always say that it is the distribution's fault,
or the sysadmin's fault to have such fstab entries.
Still, I think the situation can be improved.

On the other hand, I am told that recent kernels restrict the use of
loadkeys to root. If so, an unfortunate choice. People want to switch
unicode support on/off, or go from/to a dvorak keymap.
What was the security problem? I understand the reasoning was that
someone could invent malicious function key bindings, and leave those
for the user that logs in after him. Yes, true.
But my solution would be in user space, not by crippling the kernel.
If it is necessary that a user who logs in gets a default environment
at login time, that is the responsibility of login, not of the kernel.
It is very easy to arrange such things, and of course in places where
some but not all of the users use dvorak, such things are done already
today.

I have been going away from Linux for a while now - gave most of my
packages to other maintainers - but there is still kbd.
If someone is willing to maintain it, please tell me. A new version
is required because 2.6 has broken a number of things.

Andries
