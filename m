Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132376AbQLVUes>; Fri, 22 Dec 2000 15:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132374AbQLVUei>; Fri, 22 Dec 2000 15:34:38 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:6672
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S132370AbQLVUeZ>; Fri, 22 Dec 2000 15:34:25 -0500
Date: Fri, 22 Dec 2000 12:03:18 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: lk@mailandnews.com, linux-kernel@vger.kernel.org,
        CPRM Account <cprm@linux-ide.org>
Subject: Re: CPRM copy protection for ATA drives
In-Reply-To: <E148tzm-0002KI-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10012221135330.5416-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


READ and reply to CPRM Account <cprm@linux-ide.org> Only...
It is not worth the kernel traffic to blow appart the issue.

On Thu, 21 Dec 2000, Alan Cox wrote:

> > Does anyone have any details on this? I presume that the drive
> > firmware is capable of identifying copy-protected data during
> > a write. I also presume that nobody on lkml would condone
> 
> It seems to be very similar to the DVD stuff, including ideas for play once
> only blocks and the like. Pay per read hard disk...

That is part of the potentially hidden issue is the usage counters.

> > such a terrible idea. I imagine that this system is pretty
> > easy to defeat if you can modify the filesystem. Perhaps even
> 
> Its probably very hard to defeat. It also in its current form means you can
> throw disk defragmenting tools out. Dead, gone. Welcome to the United Police
> State Of America.

No.  Just blame the MPA (Motion Picture Association) for this level of
paranoia.  The object is to follow the money and the fronts that are
hiding real issues.

> > The consequences of being able to corrupt other people's backups
> > by introducing "copy-protected" data are intriguing...
> 
> I'm just waiting for a few class action law suits against drive manufacturers
> when people's backup tools cannot cope

Oh, this is one of the issues that I brought up along with many others
during the December Plenary Meeting.  For the record, I was able to
intensify the issue by my objections to postpone the adoption for 60 days.
This subject will come up again in February.  Since I can only represent
my interest as a counsultant to the T13 Committee, because there is not
organization offically known as "Linux".

I do expect to take a lot of heat on CPRM, but everyone here knows that I
can take as much as I dish it!  If you wish to send a note to complain
about the issue, I will carry your points to the meeting.

CPRM Account <cprm@linux-ide.org>

Do not blow torch me or the issue.
Explain why you have issues.
Explain what is a better solution.

For the next point of record, I will be supporting Microsoft's proposal.
It is the only one that will not effect us in a way that could be harmful.
ftp://fission.dt.wdc.com/pub/standards/x3t13/technical/e00163r0.pdf

Additionally, Linux will have to deploy a command filter driver to force
block the use of CPRM taskfile calls by browsers, which is the suspected
method of performing this protected mode of access.  The option will be
submitted/included in the next rev of the kernel for v2.5.0 at the time of
its annoucement.  The default will be to block the is command set and you
will have to compile the option in to allow the technically correct
command to be accepted.

Lastly, I may end up losing my position on the Committee but hey it is for
a good cause ;-)

Regards,

Andre Hedrick
Linux ATA Development



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
