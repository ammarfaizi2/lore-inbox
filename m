Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263453AbTJZT21 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 14:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbTJZT21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 14:28:27 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:55781 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S263453AbTJZT20
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 14:28:26 -0500
Date: Mon, 27 Oct 2003 08:28:14 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [Swsusp-devel] Announce: Swsusp-2.0-2.6-alpha1
In-reply-to: <200310261250.36616.aviram@jenik.com>
To: Aviram Jenik <aviram@jenik.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: swsusp-devel <swsusp-devel@lists.sourceforge.net>
Message-id: <1067196494.14422.203.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1067064107.1974.44.camel@laptop-linux>
 <200310261250.36616.aviram@jenik.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I forgot to mention that you need to echo 1 > /proc/swsusp/enable_escape
for pressing escape to work. (It's mentioned in
Documentation/power/swsusp.txt).

Sorry.

Nigel

On Sun, 2003-10-26 at 23:50, Aviram Jenik wrote:
> Hi,
> 
> I tried swsusp on 2.6.0-test9. Patch was applied cleanly, but for compilation 
> to work I needed to apply Pavel's scsi one-liner patch.
> 
> I tried hibernation with echo > /proc/swsusp/activate, but it was stuck on 
> "Freezing processes: Waiting for activity to finish".
> 
> On Saturday 25 October 2003 08:41, Nigel Cunningham wrote:
> >
> > In addition, you may see freezing failures. If
> > the process hangs at 'Freezing processes: Waiting for activity to
> > finish' or 'Syncing remaining I/O', try pressing escape once. 
> 
> I tried several times pressing "ESC", but nothing happened. 'l' and 'r' did 
> change the display, but there was nothing in the logs (I had to do a cold 
> reboot).
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

