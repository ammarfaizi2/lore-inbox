Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbTGAPfe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 11:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbTGAPfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 11:35:34 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:29351 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262497AbTGAPf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 11:35:26 -0400
Reply-To: <vlad@lrsehosting.com>
From: <vlad@lrsehosting.com>
To: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: bkbits.net is down
Date: Tue, 1 Jul 2003 10:46:13 -0500
Message-ID: <002a01c33fe7$e7718e40$0200a8c0@wsl3>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <1056773286.10255.5.camel@granite>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is why all my clients get HP 7504a tape drives in their tape servers.
40/80GB tape that can do disaster recovery is a GOOD thing!  :-)

--

 /"\                         / For information and quotes, email us at
 \ /  ASCII RIBBON CAMPAIGN / info@lrsehosting.com
  X   AGAINST HTML MAIL    / http://www.lrsehosting.com/
 / \  AND POSTINGS        / vlad@lrsehosting.com
-------------------------------------------------------------------------

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Joshua Penix
Sent: Friday, June 27, 2003 11:08 PM
To: Linux Kernel Mailing List
Subject: Re: bkbits.net is down


On Fri, 2003-06-27 at 20:19, Larry McVoy wrote:
> On Fri, Jun 27, 2003 at 08:51:40PM -0400, Scott McDermott wrote:
> > Larry McVoy on Fri 27/06 17:16 -0700:
> > > I don't know if you all realize this but at one point we
> > > had corrupted data in several repositories and the backups
> > > were also shot.
> >
> > ever hear of tapes?
>
> bkbits is 45GB of data and growing.  Tapes are completely impractical,
> that's why we have hot spares.

Boy you do need a good admin :)  Done correctly, tapes are quite
practical for that amount of data.  A LTO or SDLT drive would back the
entire 45GB thing up on a single tape, with room for at least one to two
more full backups.  Granted, you're not going to have tape act as your
hot backup, but it is a good third line of defense.  Plus data backed up
to tape is immune from human or software error that may otherwise affect
the hard-drive based data.

45GB of code is very compressible and I'm sure good chunks of that don't
change on a weekly basis.  I'd imagine you could get a weekly or
bi-weekly full backup to tape in the span of about two hours, and then
do nightly differentials which would probably be only 15 minutes in
length.  A filesystem capable of doing snapshots would ensure
consistency of the repositories on tape and would prevent you from
having to shutdown bkbits while backing up.

--Josh

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


