Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130219AbRAKR0j>; Thu, 11 Jan 2001 12:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130392AbRAKR03>; Thu, 11 Jan 2001 12:26:29 -0500
Received: from marine.sonic.net ([208.201.224.37]:30512 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S130387AbRAKR0W>;
	Thu, 11 Jan 2001 12:26:22 -0500
X-envelope-info: <dhinds@sonic.net>
Message-ID: <20010111092601.B23489@sonic.net>
Date: Thu, 11 Jan 2001 09:26:01 -0800
From: David Hinds <dhinds@sonic.net>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Miles Lane <miles@megapathdsl.net>,
        Aaron Eppert <eppertan@rose-hulman.edu>, dhinds@zen.stanford.edu,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 Patch for 3c575
In-Reply-To: <20010110204420.A7699@rose-hulman.edu> <3A5D20D6.6090906@megapathdsl.net>, <3A5D20D6.6090906@megapathdsl.net>; <20010110201537.F12593@sonic.net> <3A5D9F3A.FCC82709@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3A5D9F3A.FCC82709@uow.edu.au>; from Andrew Morton on Thu, Jan 11, 2001 at 10:55:38PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2001 at 10:55:38PM +1100, Andrew Morton wrote:
> 
> The other problem is that in 2.4 cardmgr isn't told the
> name of the interface which was bound to the newly-inserted NIC.
> I don't know why more people aren't getting bitten by this
> with pcmcia-cs+2.4.

2.4 cardmgr should be fixed to not even look for a device name for the
NIC, since now this is /sbin/hotplug's job (though I'm not sure it is
ready for that responsibility at this point).

-- Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
