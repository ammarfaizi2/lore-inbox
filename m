Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265303AbUEZEOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265303AbUEZEOz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 00:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265304AbUEZEOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 00:14:55 -0400
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:11582 "EHLO
	mail.asahi-net.or.jp") by vger.kernel.org with ESMTP
	id S265303AbUEZEOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 00:14:53 -0400
Message-ID: <40B419B6.2040507@ThinRope.net>
Date: Wed, 26 May 2004 13:14:46 +0900
From: Kalin KOZHUHAROV <kalin@ThinRope.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: bg, en, ja, ru, de
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.6 and hard drive power-off on reboot?
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been using linux-2.6.6 for almost 2 weeks now, but I have rebooted only once till today...

As I was playing with some options and had to reboot quite a few times today, I noticed that on each reboot (Ctrl+Alt+Del), all hard drives are powerd down (a loud noise of the heads being parked and drive spinned down can be heard).
When the machine boots again, there is a considerable delay (1-2s) when each hard drive is reinitialized/spinned-up.

This was not the case in 2.6.5.
Is there any way to change this in 2.6.6?

Did I turn on/off something by chance in the .config?
I just did:
gzcat /proc/config.gz |diff -u -- /usr/src/linux-2.6.5/.config -
but I cannot see anything suspicious, although there are quite a few changes, mainly inm order to have more modules.

No ideas how to "debug" such situations...

Kalin.

-- 
||///_ o  *****************************
||//'_/>     WWW: http://ThinRope.net/
|||\/<" 
|||\\ ' 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
