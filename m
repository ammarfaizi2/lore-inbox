Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRADWg4>; Thu, 4 Jan 2001 17:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132210AbRADWgr>; Thu, 4 Jan 2001 17:36:47 -0500
Received: from mailout1-1.nyroc.rr.com ([24.92.226.146]:17704 "EHLO
	mailout1-1.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S129183AbRADWgf>; Thu, 4 Jan 2001 17:36:35 -0500
Message-ID: <003a01c0769f$0a12b650$0701a8c0@morph>
From: "Dan Maas" <dmaas@dcine.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.e3022cv.v2ucim@ifi.uio.no> <fa.naq8vev.74ai08@ifi.uio.no>
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
Date: Thu, 4 Jan 2001 17:38:11 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Being able to shut down by hitting the power switch is a little luxury
> > for which I've been willing to invest more than a year of my life to
> > attain.  Clueless newbies don't know why it should be any other way, and
> > it's essential for embedded devices.

Just some food for thought - hitting the power switch on my old Indy
actually performs the equivalent of "shutdown -r now"; the system only cuts
the power when it's done cleaning up (sometimes several minutes later). I
suspect most workstation-class systems do similar things.

Of course this creates a confusing distinction between "pulling the plug"
and "hitting the power switch." Uninformed users might even be more
bewildered by the flurry of disk activity after performing the latter; heck,
I wouldn't blame someone who freaks out and pull the plug to make it stop
=).

Also, such a system obviously has little benefit in the event of an AC power
failure.

Dan


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
