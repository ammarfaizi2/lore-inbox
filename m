Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbTHUG7h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 02:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262475AbTHUG7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 02:59:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:43497 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262477AbTHUGjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 02:39:23 -0400
Date: Wed, 20 Aug 2003 23:41:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Zwickel <martin.zwickel@technotrend.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-t3: vfs/ext3 do_lookup bug?!
Message-Id: <20030820234119.33362f7a.akpm@osdl.org>
In-Reply-To: <20030821083337.6fc701b9.martin.zwickel@technotrend.de>
References: <20030820171431.0211930e.martin.zwickel@technotrend.de>
	<20030820113625.6a75d699.akpm@osdl.org>
	<bi0grq$49r$1@build.pdx.osdl.net>
	<20030821083337.6fc701b9.martin.zwickel@technotrend.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Zwickel <martin.zwickel@technotrend.de> wrote:
>
> cutted-dmesg.txt  text/plain (15496 bytes)

Try `dmesg -s 1000000'.   The silly thing has too small a buffer.

