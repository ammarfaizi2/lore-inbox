Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132488AbQKZSiQ>; Sun, 26 Nov 2000 13:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132503AbQKZSiH>; Sun, 26 Nov 2000 13:38:07 -0500
Received: from lin-hs5-015.inetnebr.com ([209.50.4.143]:26105 "EHLO
        falcon.inetnebr.com") by vger.kernel.org with ESMTP
        id <S132488AbQKZSh4>; Sun, 26 Nov 2000 13:37:56 -0500
Date: Sun, 26 Nov 2000 12:07:38 -0600
From: Jeff Epler <jepler@inetnebr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11(-ac4)/i386 configure bug
Message-ID: <20001126120738.A2684@potty.housenet>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20001126101115.A2502@potty.housenet> <20001126163801.A23819@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20001126163801.A23819@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2000 at 04:38:01PM +0000, Tim Waugh wrote:
> On Sun, Nov 26, 2000 at 10:11:15AM -0600, Jeff Epler wrote:
> 
> > (not affected by the -ac4 patch, the file in question is not touched)
> > 
> > Parallel printer support (CONFIG_PRINTER) [N/m/?] (NEW) m
> >   Support for console on line printer (CONFIG_LP_CONSOLE) [N/y/?] (NEW)
> > 
> > Suggested change:
> 
> What's wrong with it?

How can you have the console on a modularized device?

Above, this is correctly forbidden for serial console.

Or can I dynamically change the console device after bootup?

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
