Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129228AbQKWWT3>; Thu, 23 Nov 2000 17:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129401AbQKWWTU>; Thu, 23 Nov 2000 17:19:20 -0500
Received: from [216.161.55.93] ([216.161.55.93]:10994 "EHLO blue.int.wirex.com")
        by vger.kernel.org with ESMTP id <S129228AbQKWWTD>;
        Thu, 23 Nov 2000 17:19:03 -0500
Date: Thu, 23 Nov 2000 13:48:04 -0800
From: Greg KH <greg@wirex.com>
To: f5ibh <f5ibh@db0bm.ampr.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18pre, usb mouse messages
Message-ID: <20001123134804.C28923@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>, f5ibh <f5ibh@db0bm.ampr.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <200011232132.WAA29552@db0bm.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200011232132.WAA29552@db0bm.ampr.org>; from f5ibh@db0bm.ampr.org on Thu, Nov 23, 2000 at 10:32:01PM +0100
X-Operating-System: Linux 2.2.17-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2000 at 10:32:01PM +0100, f5ibh wrote:
> Hi,
> 
> I use an USB mouse, it works perfectly both with 'gpm' and with X-window but
> time to time, I've this kind of message stream :
> 
> [root@debian-f5ibh] ~ # usb-uhci.c: interrupt, status 3, frame# 20
> usb-uhci.c: interrupt, status 3, frame# 44
> usb-uhci.c: interrupt, status 3, frame# 68
> usb-uhci.c: interrupt, status 3, frame# 92
> usb-uhci.c: interrupt, status 3, frame# 116
> usb-uhci.c: interrupt, status 3, frame# 140
> usb-uhci.c: interrupt, status 3, frame# 164
> usb-uhci.c: interrupt, status 3, frame# 188
> usb-uhci.c: interrupt, status 3, frame# 212
> hub.c: already running port 2 disabled by hub (EMI?), re-enabling...
> 
> This message appears with most (all ?) of the 2.2.18pre releases, the actual
> one is 2.2.18pre23.

The messages are harmless debug messages.  Anyone want to whip up a
patch to turn them off (like was recently done for 2.4.0-test)?  If no
one else does, I can do it later this weekend...

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
