Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267363AbTGWKgI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 06:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267401AbTGWKgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 06:36:08 -0400
Received: from pat.ukc.ac.uk ([129.12.21.15]:36075 "EHLO pat")
	by vger.kernel.org with ESMTP id S267363AbTGWKgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 06:36:02 -0400
To: Andre Hedrick <andre@linux-ide.org>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, andersen@codepoet.org,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: Promise SATA driver GPL'd
References: <Pine.LNX.4.10.10307222219300.10927-100000@master.linux-ide.org>
From: Adam Sampson <azz@us-lot.org>
Organization: Don't wake me, 'cos I'm dreaming, and I might just stay inside
 again today.
Date: Wed, 23 Jul 2003 11:40:37 +0100
In-Reply-To: <Pine.LNX.4.10.10307222219300.10927-100000@master.linux-ide.org> (Andre
 Hedrick's message of "Tue, 22 Jul 2003 22:28:26 -0700 (PDT)")
Message-ID: <y2a8yqpeday.fsf@cartman.at.fivegeeks.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-UKC-Mail-System: No virus detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick <andre@linux-ide.org> writes:

> To bad people do not see the lameness of GPL and the superior
> quality of OSL.

>From a not-a-lawyer viewpoint, there's one major thing that concerns
me about the OSL 1.1 (the text of which is available on
opensource.org):

  If You distribute copies of the Original Work or a Derivative Work,
  You must make a reasonable effort under the circumstances to obtain
  the express and volitional assent of recipients to the terms of this
  License.

This "click-wrap" requirement sounds like it would cause problems for
mirror sites; we'd have to either make our users accept that there
might be software licensed under the OSL somewhere on the site before
browsing any of it -- which is ridiculous, since the vast majority of
our mirrored software isn't under such a license -- or scan all
software we mirror for OSL licenses and require acceptance on a
per-file basis, which would be possible, but a reasonably large amount
of development work, and annoying both for users and for other sites
mirroring from us.

In particular, how are we meant to enforce this for an FTP or rsync
server? We can put "Downloading software under the terms of the OSL
requires acceptance of the terms; logging in to this server indicates
your acceptance of these terms" or something similar in our
message-of-the-day, but that doesn't seem like "expressing assent"
when we know full well that the majority of FTP users won't get shown
the MOTD.

Now, we could argue that just putting a notice in our terms and
conditions saying that we might have OSL-licensed software would be a
"reasonable effort", but there's no guarantee that the copyright owner
would consider this reasonable, and it certainly doesn't seem
compliant with the spirit of the license. (Essentially, this is the
same problem that the GPL has with defining a "derivative work"; the
OPL doesn't fix this problem either.) I also don't like the idea of
having to do this for every future license that appears that also
includes these terms.

Otherwise, the license looks like a nice idea. But this clause, if
it's intended to do what I think it is, would cause serious problems
for the large number of mirror sites out there who carry free
software.

(The other concerns I've seen voiced about this license are the
"External Deployment" section, which I'm quite happy with, and the
validity of the "Jurisdiction" and "Attorneys' Fees" sections, which
look like a nice idea that wouldn't actually be possible under some
jurisdictions -- have a look in the archives of debian-legal for some
more-informed discussion about this.)

-- 
Adam Sampson <azz@us-lot.org>                   <http://azz.us-lot.org/>
