Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbTEEMtp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 08:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbTEEMtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 08:49:45 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:5952 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S262166AbTEEMto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 08:49:44 -0400
Message-ID: <3EB66069.2090104@myrealbox.com>
Date: Mon, 05 May 2003 06:00:25 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.69 
References: <fa.m5ekdiv.15gu98j@ifi.uio.no>
In-Reply-To: <fa.m5ekdiv.15gu98j@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

<much snippage>

> Jeff Garzik:
>   o [netdrvr tg3] detect shared (and screaming) interrupts
>   o [netdrvr tg3] fix omission in board shutdown sequence

I had high hopes for these patches but unfortunately they didn't
fix the problem I've had with the built-in Broadcom chip on the
ASUS A7V8X motherboard:  after bootup I still need to do an
'ifconfig eth0 down' followed by 'ifconfig eth0 up' before the
chip will actually start passing packets.  From then 'til the
next reboot the chip works fine.

> Patrick Mansfield:
>   o fix ppa locking and oops

My parallel-port ZIP drive finally works, thanks!

