Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270383AbTGMUwF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 16:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270392AbTGMUwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 16:52:05 -0400
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:54158 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S270383AbTGMUwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 16:52:04 -0400
Message-ID: <3F1163A7.6010004@tuxfamily.org>
Date: Sun, 13 Jul 2003 15:50:31 +0200
From: Anthony Lichnewsky <lich@tuxfamily.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030617
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.75 doesn't boot at all on x86
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After lilo, the kernel is uncompressed, then the screen goes black.
the traditional init message is not even displayed
( INIT version 2.85 booting ).
It accepts Ctrl+Alt+Suppr for reboot. but that's it.

I checked that CONFIG_VT, CONFIG_VGA_CONSOLE are set in my .config.
I suspect the initrd image is not loaded correctly, but I don't have any
real clue. It was generated with mkinitrd version 3.4.43.
Any Idea of what it might be ?

please cc me.

-anthony


