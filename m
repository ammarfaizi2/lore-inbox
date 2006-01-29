Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbWA2LJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWA2LJc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 06:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbWA2LJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 06:09:32 -0500
Received: from uproxy.gmail.com ([66.249.92.201]:26402 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750922AbWA2LJb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 06:09:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=J3AIjti/MkBHZe2cFc9lT2Nv/+5TW0WE8PBUBY7OhRc71QFLD5FMsxKbDPBGDQRlUr4n2JEqp6S5/uvOqvGG9zVW1VV6nBZjEPcpMLK1v1iFPbMgDEtMuzTGS+48fQz9rDTUdhZOeVZMbjqYvooDKVW+emlN+fClip07W7piB8E=
From: Marek =?utf-8?q?Va=C5=A1ut?= <marek.vasut@gmail.com>
To: dtor_core@ameritech.net
Subject: Re: [PATCH] iforce: fix -ENOMEM check
Date: Sun, 29 Jan 2006 12:09:15 +0100
User-Agent: KMail/1.7.2
References: <200601281903.28176.marek.vasut@gmail.com> <200601282314.21222.dtor_core@ameritech.net>
In-Reply-To: <200601282314.21222.dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601291209.15864.marek.vasut@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dne neděle 29 ledna 2006 05:14 jste napsal(a):
> On Saturday 28 January 2006 13:03, Marek Vašut wrote:
> > I have tried that patch, but nothing changed ...
> > That error is still there and no new device in /dev/input appears
>
> You do have updated udev, don't you? Could you pease post your dmesg
> with the patch applied?

usb 4-2: new full speed USB device using uhci_hcd and address 2
usb 4-2: configuration #1 chosen from 1 choice
iforce-main.c: Timeout waiting for response from device.
usbcore: registered new driver iforce

I´ve cut off the unnecessary parts. This is what shows up when I connect it.
There is no js0 in /dev/input ... thats weird, isn´t it?
