Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262090AbUKPSxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbUKPSxd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 13:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbUKPSxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 13:53:33 -0500
Received: from zamok.crans.org ([138.231.136.6]:16056 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S262090AbUKPSxb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 13:53:31 -0500
To: reiserfs-list@namesys.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: 2.6.10-rc2-mm1: oops when accessing reiser4 fs's (maybe fix provided)
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Tue, 16 Nov 2004 19:53:30 +0100
Message-ID: <874qjptyl1.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I tried 2.6.10-rc2-mm1 and the last reiser4 updates gave some (many many)
oopses flooding my screen :).
I tried reverting reiser4-fix-deadlock.patch and oopses are gone.

I tried this one because thru the quick traces on my screen, I saw a reference
to get_current_context.
The speed of the traces and the unasibility of the box prevented me from
making differences between "real" oopses and BUG_ON(), sorry for that...

If you want some traces I can provide them ASAP (e.g. tomorrow)

Best,

-- 
"I am getting pretty good at running diff and patch now."

	- Jeff Merkey

