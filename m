Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130805AbRBQTDl>; Sat, 17 Feb 2001 14:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130877AbRBQTDd>; Sat, 17 Feb 2001 14:03:33 -0500
Received: from colorfullife.com ([216.156.138.34]:52241 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130805AbRBQTDS>;
	Sat, 17 Feb 2001 14:03:18 -0500
Message-ID: <3A8ECB1B.776D0372@colorfullife.com>
Date: Sat, 17 Feb 2001 20:03:55 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1-ac15 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Mark Swanson <swansma@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: System V msg queue bugs in latest kernels
In-Reply-To: <20010217184242.1070.qmail@web1302.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Swanson wrote:
> 
> Hello,
> 
> ipcs (msg) gives incorrect results if used-bytes is above 65536. It
> stays at 65536 even though messages are being read and removed from the
> msg queue.
>
I'm testing it.

Could you check /proc/sysvipc/msg?

I know that several API's have 16-bit numbers, perhaps wrong values are
returned to user space.

--
	Manfred
