Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbVJOBzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbVJOBzn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 21:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbVJOBzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 21:55:43 -0400
Received: from xenotime.net ([66.160.160.81]:63919 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751023AbVJOBzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 21:55:42 -0400
Date: Fri, 14 Oct 2005 18:55:41 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Marc Perkel <marc@perkel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Forcing an immediate reboot
Message-Id: <20051014185541.38ca06b0.rdunlap@xenotime.net>
In-Reply-To: <43505F86.1050701@perkel.com>
References: <43505F86.1050701@perkel.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Oct 2005 18:46:46 -0700 Marc Perkel wrote:

> Is there any way to force an immediate reboot as if to push the reset 
> button in software? Got a remote server that i need to reboot and 
> shutdown isn't working.

What kernel version?
Does it have sysrq enabled?

If 2.6.x and Yes, then you should be able to do:
  echo b > /proc/sysrq-trigger

to cause a reboot.

---
~Randy
