Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318143AbSHDKVI>; Sun, 4 Aug 2002 06:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318144AbSHDKVI>; Sun, 4 Aug 2002 06:21:08 -0400
Received: from mta06bw.bigpond.com ([139.134.6.96]:3292 "EHLO
	mta06bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S318143AbSHDKVH>; Sun, 4 Aug 2002 06:21:07 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Felix Seeger <felix.seeger@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19, usb mouse is gone
Date: Sun, 4 Aug 2002 20:19:47 +1000
User-Agent: KMail/1.4.5
References: <200208041217.51250.felix.seeger@gmx.de>
In-Reply-To: <200208041217.51250.felix.seeger@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200208042019.47553.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Aug 2002 20:17, Felix Seeger wrote:
> Hi
>
> What happens to the usb mouse in 2.4.19 ?
You copied .config from the previous version, and didn't check
if anything had changed.

> After my update I had to switch to ps/2 because it doesn't work.
Of course it doesn't work. You (by inaction) turned it off.

Try turning on CONFIG_USB_HIDINPUT.

Checking the mailing list archives would have been productive too.

Brad
-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
