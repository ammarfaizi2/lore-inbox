Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264254AbTEaJVu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 05:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbTEaJVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 05:21:50 -0400
Received: from A17-250-248-86.apple.com ([17.250.248.86]:7158 "EHLO
	smtpout.mac.com") by vger.kernel.org with ESMTP id S264254AbTEaJVo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 05:21:44 -0400
Date: Sat, 31 May 2003 19:34:42 +1000
Subject: Re: warning: process 'update' used the obsolete bdflush...
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: <linux-kernel@vger.kernel.org>, <rol@as2917.net>
To: "Paul Rolland" <rol@witbe.net>
From: Stewart Smith <stewartsmith@mac.com>
In-Reply-To: <006a01c32753$9fdac7b0$2101a8c0@witbe>
Message-Id: <1B8F41EC-934B-11D7-B416-00039346F142@mac.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, May 31, 2003, at 07:04  PM, Paul Rolland wrote:

> Hello,
>
> When switching from 2.4.20 to 2.5.x (x being recent), I have this
> message...
>
> What does this mean ?
> 1 - I have no process named update running,
> 2 - I can't find anything name update in /etc/rc.d/* recursively.

from fs/buffer.c:
/*
  * There are no bdflush tunables left.  But distributions are
  * still running obsolete flush daemons, so we terminate them here.
  *
  * Use of bdflush() is deprecated and will be removed in a future 
kernel.
  * The `pdflush' kernel threads fully replace bdflush daemons and this 
call.
  */

I'd upgrade whatever package update comes from. I can't seem to find 
that binary around on some of my systems, what distribution and version 
are you running? Maybe it's time to upgrade.

Someone else might know specifics :)
------------------------------
Stewart Smith
stewartsmith@mac.com
Ph: +61 4 3884 4332
ICQ: 6734154
http://www.flamingspork.com/       http://www.linux.org.au

