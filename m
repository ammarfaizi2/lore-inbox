Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbUDYIwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbUDYIwZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 04:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263000AbUDYIwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 04:52:24 -0400
Received: from opersys.com ([64.40.108.71]:43536 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262981AbUDYIwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 04:52:19 -0400
Message-ID: <408B7DA4.7010101@opersys.com>
Date: Sun, 25 Apr 2004 04:58:12 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Hand with radeon 9000 / AGP / DRI
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been playing around trying to get the most out of my Radeon
9000 pro with a 2.4.x kernel and I must admit that I've been
somewhat disapointed. There are two things I've been trying to get
to work properly:
1) RadeonFB
2) Direct rendering in X (needs DRI and AGP)

The first one actually works, but only if I set "mem=840MB" at
startup (I've got 1GB.) Not sure I see why I need to give up
some memory here. Maybe I'm just missing something ...

The second needs some tweaking before it can start being played
with (http://marc.theaimsgroup.com/?l=linux-kernel&m=107073819005830&w=2).
But even then, it's not really stable. I just go in KDE's screensaver
config menu, select "Flux (GL)"->Setup and try a few different types.
Usually, but the time I've selected to preview a third type (regardless
of the name, it's just any third), the machine simply hangs, and I
have to hard reset. I'm not sure how this propagates down to the kernel
in terms of calls/accesses, but it's really not an issue with time (i.e.
leaving the screensaver run for a while will not cause any hangs,) it's
an issue with changing the screensaver config a limited number of times,
usually three times.

Here's some more info about the config:
- RedHat 9
- P4 2.4GHz with HT
- P4C800-Deluxe Asus board (intel 875 chipset)
- 1GB RAM
- Tried with a 2.4.26 with the above-mentioned patch

Anyone have something like this working?

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

