Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268054AbUJDMBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268054AbUJDMBP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 08:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268057AbUJDMBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 08:01:15 -0400
Received: from dialpool1-171.dial.tijd.com ([62.112.10.171]:5762 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S268054AbUJDMBN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 08:01:13 -0400
From: Jan De Luyck <lkml@kcore.org>
To: Oliver Neukum <oliver@neukum.org>
Subject: Re: [2.6.9-rc3] suspend-to-disk oddities
Date: Mon, 4 Oct 2004 13:59:06 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <200410041107.12049.lkml@kcore.org> <200410041331.44453.oliver@neukum.org>
In-Reply-To: <200410041331.44453.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200410041359.07047.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 October 2004 13:31, Oliver Neukum wrote:
> Am Montag, 4. Oktober 2004 11:07 schrieb Jan De Luyck:
> > Just tried swsusp, works great, besides a few strange things:
> >
> > - The suspend routine is unable to shutdown the mysqld process:
> >
> > Oct  4 10:19:43 precious kernel: Stopping tasks:
> > ================================================= Oct  4 10:19:43
> > precious kernel:  stopping tasks failed (1 tasks remaining) Oct  4
> > 10:19:43 precious kernel: Restarting tasks...<6> Strange, mysqld not
> > stopped Oct  4 10:19:43 precious kernel:  done
> >
> > - USB subsystem is totally unworking until I reinitialise it (using
> > /etc/init.d/hotplug restart)
>
> Precisely how does it fail?

This is after a successfull suspend-resume.

It doesn't work, period. No messages in the logs, anything I plug in isn't 
reacted to, lsusb gives nothing. It's just 'not there'.

Jan

-- 
BOFH excuse #136:

Daemons loose in system.
