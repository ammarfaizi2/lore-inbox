Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129798AbRAKRb3>; Thu, 11 Jan 2001 12:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130329AbRAKRbT>; Thu, 11 Jan 2001 12:31:19 -0500
Received: from marine.sonic.net ([208.201.224.37]:31311 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S129798AbRAKRbA>;
	Thu, 11 Jan 2001 12:31:00 -0500
X-envelope-info: <dhinds@sonic.net>
Message-ID: <20010111093035.E23489@sonic.net>
Date: Thu, 11 Jan 2001 09:30:35 -0800
From: David Hinds <dhinds@sonic.net>
To: Andrew Morton <andrewm@uow.edu.au>,
        Troels Walsted Hansen <troels@thule.no>
Cc: linux-kernel@vger.kernel.org, greg@wind.enjellic.com, joey@linux.de
Subject: Re: [PATCH] klogd busy loop on zero byte (output from 3c59x driver)
In-Reply-To: <CKECLHEEHJOPHGPCOCKPEECCCCAA.troels@thule.no> <3A5DA113.DC8DB21C@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3A5DA113.DC8DB21C@uow.edu.au>; from Andrew Morton on Thu, Jan 11, 2001 at 11:03:31PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2001 at 11:03:31PM +1100, Andrew Morton wrote:
> 
> Yep.  %02x%02x it now is.
> 
> The code in question was snitched from pcmcia-cs's 3c575_cb.c, and
> I assume David would have heard if it was busting klogd.  Maybe
> there's a klogd version problem, or maybe your NIC's EEPROM is hosed?

I haven't heard of it before: I've never seen a card claim to have 0's
for its ascii product code.  What card is it, exactly?

-- Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
