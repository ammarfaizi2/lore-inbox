Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132286AbQK3AJ3>; Wed, 29 Nov 2000 19:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132300AbQK3AJT>; Wed, 29 Nov 2000 19:09:19 -0500
Received: from 33.136.8.rrcentralflorida.cfl.rr.com ([65.33.136.8]:1534 "EHLO
        sasami.kuroyi.net") by vger.kernel.org with ESMTP
        id <S132286AbQK3AJE>; Wed, 29 Nov 2000 19:09:04 -0500
Date: Wed, 29 Nov 2000 18:38:34 -0500
From: Rick Haines <rick@kuroyi.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@redhat.com>
Subject: Re: test12-pre3 (broke my usb)
Message-ID: <20001129183834.A443@sasami.kuroyi.net>
In-Reply-To: <Pine.LNX.4.10.10011282248530.6275-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10011282248530.6275-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Nov 28, 2000 at 10:57:35PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2000 at 10:57:35PM -0800, Linus Torvalds wrote:
>  - pre3:
>     - Johannes Erdfelt: USB update

Seems to have broken my IntelliMouse Optical (logs from the third time
I inserted usb-uhci):

Nov 29 17:12:08 sasami kernel: usb-uhci.c: Detected 2 ports
Nov 29 17:12:08 sasami kernel: usb.c: new USB bus registered, assigned bus number 1
Nov 29 17:12:08 sasami kernel: hub.c: USB hub found
Nov 29 17:12:08 sasami kernel: hub.c: 2 ports detected
Nov 29 17:12:08 sasami kernel: hub.c: USB new device connect on bus1/1, assigned device number 5
Nov 29 17:12:11 sasami kernel: usb_control/bulk_msg: timeout
Nov 29 17:12:11 sasami kernel: usb.c: USB device not accepting new address=5 (error=-110)
Nov 29 17:12:11 sasami kernel: hub.c: USB new device connect on bus1/1, assigned device number 6
Nov 29 17:12:14 sasami kernel: usb_control/bulk_msg: timeout
Nov 29 17:12:14 sasami kernel: usb.c: USB device not accepting new address=6 (error=-110)

-- 
Rick (rick@kuroyi.net)
http://www.kuroyi.net

I think the slogan of the fansubbers puts
it best: "Cheaper than crack, and lots more fun."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
