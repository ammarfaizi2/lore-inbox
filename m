Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263065AbTIEPoB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 11:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263064AbTIEPoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 11:44:01 -0400
Received: from mail.localaccess.com ([69.10.201.41]:3081 "EHLO
	ATHERA.localaccess.com") by vger.kernel.org with ESMTP
	id S263065AbTIEPn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 11:43:58 -0400
Subject: Re: 2.6.0-test4-mm6
From: Matthew Trent <mtrent@localaccess.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Local Access Communications
Message-Id: <1062776622.1599.79.camel@alderaan.localaccess.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 05 Sep 2003 08:43:42 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 3. The oss mixer emulation doesn't load correctly, I get the following
> > messages in the syslog, f.e. after a "modprobe snd-mixer-oss":
> >
> > snd: Unknown parameter `device_mode'
> 
> I had to remove the device_mode option from below in /lib/modules/
> modprobe.conf. It happens in test4 too i think.
> 
> options snd major=116 cards_limit=4 device_mode=0660

I encountered the same thing with device_mode.

As a side note, I've been lurking here for a while and I've noticed that
the latest iterations (although I've only tried Nick's once, in -mm5) of
_both_ schedulers feel great on my system. If I've been following the
thread correctly, I think the turning point was the addition of some I/O
scheduler patches (in mm3 or mm4?). Way better since then.
-- 
Matt
Local Access Communications
360.330.5535



