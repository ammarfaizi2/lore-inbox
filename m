Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289165AbSA1IaO>; Mon, 28 Jan 2002 03:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289162AbSA1IaF>; Mon, 28 Jan 2002 03:30:05 -0500
Received: from server.aero.polimi.it ([131.175.154.199]:37598 "EHLO
	server.aero.polimi.it") by vger.kernel.org with ESMTP
	id <S289161AbSA1I3t>; Mon, 28 Jan 2002 03:29:49 -0500
Message-ID: <3C551BAB.B8C2FB34@aero.polimi.it>
Date: Mon, 28 Jan 2002 10:36:43 +0100
From: Paolo Mantegazza <mantegazza@aero.polimi.it>
Organization: Dipartimento di Ingegneria Aerospaziale, Politecnico di Milano
X-Mailer: Mozilla 4.04 [en] (X11; I; Linux 2.4.10-rthal5 i686)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: rtai-dev@rtai.org
Subject: Announce rtai-24.1.8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The RTAI development team would like to announce the availability
of RTAI 24.1.8 which now includes support for 3 architectures: i386,
PPC and MIPS. With that said, the RTAI development team would
like to remind everyone that the continuing FUD regarding RTAI's
status in regards to the RTLinux patent is not warranted. To that
effect, the following contains a statement by Eben Moglen, the FSF's
legal counsel, dismissing any possible doubts about RTAI's use.

----------8<----------8<----------8<----------8<----------

Hi,

with the agreement of all RTAI developers I'd like to point the
following
to this list:

At www.aero.polimi.it/projects/rtai you'll find the new RTAI release
rtai-24.1.8. It improves and expands RTAI in many aspects, a lot of work
being poured into it since release 24.1.7, excerpts:

- port to MIPS by Steve Papacharalambous (stevep@lineo.com) (NEW)
- a yet more comprehensive multiarch making 
  by David Schleef (ds@schleef.org)
- many hidden rewrites and extensions to improve robustness
  and ease of use
- rt_com aligned with the latest CVS
  by Giuseppe Renoldi (giuseppe@renoldi.org)
- patches for recent kernels and the latest LTT support by
  Karym Yaghmour (karym@opersys.com)
- net_rpc to transparently support distributed use
  of RTAI services/APIs on networked applications, symmetrically in
  kernel/user space (NEW)
- last but not least, even if not cited with specific reference to
  anybody, there is a lot of very important cooperative effort from all
  RTAI friends, developers/coordinators who keep working and fighting
  friendly for this truly open source project, involving both individual
  hackers and companies.

This is a significant release - please refer to the related READMEs in
the
distribution for more in depth explanations.

I do want to take this chance to return to a many times discussed
subject
because I'm still receiving a lot of requests of clarification from many
people that are still frightened by an infamous patent and related FUD.
To
have it as short as possible I think there is no better remind and
answer
worth repeating than the one from E. Moglen (FSF).

For your convenience it is reported below, the context of the whole
message can be found at:

  http://realtimelinux.org/archives/rtai/200110/0095.html.

------------------------------------------------------------------------------
Thanks for your note.  As I have said, we have by no means ignored these
issues.  We believe on the basis of our own careful review of facts and
law, and after appropriate consultation, that there is no cause for
concern on either ground.

The new patent license allows the teaching of the patent to be practiced
without any additional obligations in any program released under GPL. 
If
RTAI is released under GPL, as it can and should be, it is fully
protected
against any infringement claim by the license we negotiated.  Any
modified
RTLinux system must be GPL'd, because RTLinux is GPL, and thus any RTL
system that is distributed in a GPL-compliant manner is also covered by
the new license. End of that aspect of the problem. The applications
problem also does not exist.  Patents, because they grant very long-term
and "strong" monopolies, are very precise documents.  A patent's
"scope,"
or the extent of its power to exclude others from its teachings, is
rigidly limited by its "claims," which are one portion of the document
that is negotiated between the inventor and the issuing Patent Office.
Anything which is not part of the patent's claims is not covered by the
patent, and can be done by anyone anywhere anytime, without regard to
the
patent.

Victor Yodaiken's patent has eleven claims.  Each of those claims covers
behavior of (1) a real-time OS kernel, (2) a general purpose OS kernel
being run as the idle-task of the RT OS, and (3) a software emulator of
hardware interrupt control, which allows the RT OS to prioritize and
present interrupts to the general purpose OS only when the RT OS has met
real-time interrupt requirements.  These eleven claims, like all claims
in
all patents, are written as broadly as possible, so as to bring as much
behavior as possible within the scope of the patent.  But none of the
teachings of the patent, as specified in its claims, is practiced by any
applications program running under any OS kernel.  No application in a
running RTLinux or RTAI system does any of the things the patent claims.

No applications program is therefore potentially infringing, and no
applications program is covered, or needs to be covered, by the license.
If an applications program running in a GNU/Linux system as modified by
RTLinux or RTAI is constructed so that it does not violate GPL--which is
not the same thing as being licensed under GPL or being free software at
all--its distribution terms are utterly irrelevant. I reviewed this
issue
carefully, as part of my own legal work negotiating the settlement, and
I
have taken additional advice from patent counsel on this and other
aspects
of the situation.  We would not have completed our arrangements if we
had
not been fully satisfied on this point.

But reality and perception differ.  Perhaps Victor has attempted to
create
the perception that he has more power over others' arrangements than he
has.  This would not be the first time in the history of business,
politics, war or even marriage that such behavior occurred. We are
seeking
one or two clarifications in statements appearing on FSM Labs' website,
which we think might inadvertently contribute to misunderstanding on
these
points.  FSF may also choose in future to make some official statement
on
these matters.  This message summarizes our view of the legal situation,
and you may redistribute it, verbatim, freely.

Best regards.
-- 
 Eben Moglen                       voice: 212-854-8382
 Professor of Law                    fax: 212-854-7946       moglen@
 Columbia Law School, 435 West 116th Street, NYC 10027     columbia.edu
 General Counsel, Free Software Foundation
 http://moglen.law.columbia.edu
------------------------------------------------------------------------------

What stated above is clear, well written and comes from a renowned
authority of legal OS stuff.  To further help fighting FUD beginning
with
this release (24.1.8) RTAI developers have also cared to have the likely
affected RTAI core functionality explicitly GPLed.  Let's hope it helps
having fainthearted Linux real timers not tricked as in "business,
politics, war or even marriages".  Emperors are often naked, do we need
to
find a kid to yell it (H.C. Handersen, The Emperor's New Clothes).

Ciao, Paolo Mantegazza
