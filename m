Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbRBHHzv>; Thu, 8 Feb 2001 02:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129281AbRBHHzl>; Thu, 8 Feb 2001 02:55:41 -0500
Received: from saw.sw.com.sg ([203.120.9.98]:17301 "HELO saw.sw.com.sg")
	by vger.kernel.org with SMTP id <S129257AbRBHHzf>;
	Thu, 8 Feb 2001 02:55:35 -0500
Message-ID: <20010208155531.A28624@saw.sw.com.sg>
Date: Thu, 8 Feb 2001 15:55:31 +0800
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Alan Cox <alan@redhat.com>, vido@ldh.org,
        Ion Badulescu <ionut@moisil.cs.columbia.edu>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: eepro100.c, kernel 2.4.1
In-Reply-To: <200102080723.f187N1v17541@moisil.dev.hydraweb.com> <200102080742.f187gqK01498@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <200102080742.f187gqK01498@devserv.devel.redhat.com>; from "Alan Cox" on Thu, Feb 08, 2001 at 02:42:52AM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2001 at 02:42:52AM -0500, Alan Cox wrote:
> > It's the printk that gets it wrong, although that's harmless.
> > Intel's documentation states that the bug does NOT exist if the
> > bits 0 and 1 in eeprom[3] are 1. Thus, the workaround is correct,
> > the printk is wrong.
> 
> So why does it fix the problem for him. His report and your reply don't
> make sense viewed together

First of all, I have information that the bug may be in 82557 only.

Augustin, could you provide full information about your cards (including the
text printed by the driver at the initialization) and elaborate on "failing
under high load"?

Best regards
		Andrey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
