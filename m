Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265025AbUKAOsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265025AbUKAOsn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 09:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264674AbUKAOsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 09:48:16 -0500
Received: from [193.112.238.6] ([193.112.238.6]:17287 "EHLO caveman.xisl.com")
	by vger.kernel.org with ESMTP id S267194AbUKAOmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 09:42:19 -0500
From: John M Collins <jmc@xisl.com>
Organization: Xi Software Ltd
To: linux-kernel@vger.kernel.org
Subject: Re: Fchown on unix domain sockets?
Date: Mon, 1 Nov 2004 14:41:56 +0000
User-Agent: KMail/1.6.1
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>
References: <200410312255.00621.jmc@xisl.com> <Pine.LNX.4.53.0411011517570.29275@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0411011517570.29275@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200411011441.56524.jmc@xisl.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 Nov 2004 14:20, Jan Engelhardt wrote:

> As some manpage might say, the socket thing you see in "ls -l" is just a
> reference thing. When you connect to it, ls -l /proc/pidofprogram/fd/ does
> not show the path, but [socket:xxxx] which shows that the filesystem object
> is not used anymore.

When I connect to it is the point. I want to set the permissions etc so that 
only the progams that are supposed to be talking to it talk to it.

> >I don't mind it not working but I think it should report an error. This is
> > on 2.6.3 kernel.
>
> What would you like it to do? EINVAL like the others or change the actual
> inode's permission?

I don't mind. I think it's a meaninful thing to want to do, but if you can't 
do it that way, fine, just let me know with some error code.

-- 
John Collins Xi Software Ltd www.xisl.com
