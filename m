Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268001AbUJDLaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268001AbUJDLaX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 07:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268019AbUJDLaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 07:30:23 -0400
Received: from mail1.kontent.de ([81.88.34.36]:51848 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S268001AbUJDLaU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 07:30:20 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Jan De Luyck <lkml@kcore.org>
Subject: Re: [2.6.9-rc3] suspend-to-disk oddities
Date: Mon, 4 Oct 2004 13:31:43 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <200410041107.12049.lkml@kcore.org>
In-Reply-To: <200410041107.12049.lkml@kcore.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200410041331.44453.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 4. Oktober 2004 11:07 schrieb Jan De Luyck:
> Just tried swsusp, works great, besides a few strange things:
> 
> - The suspend routine is unable to shutdown the mysqld process:
> 
> Oct  4 10:19:43 precious kernel: Stopping tasks: =================================================
> Oct  4 10:19:43 precious kernel:  stopping tasks failed (1 tasks remaining)
> Oct  4 10:19:43 precious kernel: Restarting tasks...<6> Strange, mysqld not stopped
> Oct  4 10:19:43 precious kernel:  done
> 
> - USB subsystem is totally unworking until I reinitialise it (using /etc/init.d/hotplug restart)

Precisely how does it fail?
Is taht after a failed suspend or after suspend?

	Regards
		Oliver

