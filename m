Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281044AbRKTLzd>; Tue, 20 Nov 2001 06:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281040AbRKTLzX>; Tue, 20 Nov 2001 06:55:23 -0500
Received: from MAILGW01.bang-olufsen.dk ([193.89.221.116]:3850 "EHLO
	mailgw01.bang-olufsen.dk") by vger.kernel.org with ESMTP
	id <S281034AbRKTLzI>; Tue, 20 Nov 2001 06:55:08 -0500
To: Robert Szentmihalyi <robert.szentmihalyi@entracom.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OT: FireWire
In-Reply-To: <200111201123592.SM00162@there>
From: Kristian Hogsberg <hogsberg@users.sourceforge.net>
Date: 20 Nov 2001 12:55:08 +0100
In-Reply-To: <200111201123592.SM00162@there>
Message-ID: <m3itc5ejxf.fsf@dk20037170.bang-olufsen.dk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BeoSmtp/Bang & Olufsen/DK(Release 5.0.6a |January
 17, 2001) at 20-11-2001 12:55:05,
	Serialize by Router on dzln11/Bang & Olufsen/DK(Release 5.0.6 |December 14, 2000) at
 20-11-2001 12:55:00,
	Serialize complete at 20-11-2001 12:55:00
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Szentmihalyi <robert.szentmihalyi@entracom.de> writes:

> Hi!
>
> Could somebody please suggest a FireWire card which is supported
> well enough for production use?
> I haven't found much information on this topic so far.

Anything with an ohci chipset should work.  The driver development is
hosted on sourceforge, see linux1394.sourceforge.net.  If you decide
to try it out, I recommend you get the latest cvs snapshot of the
drivers as described here: http://linux1394.sourceforge.net/cvs.html.

As for production use: the entire 1394 subsystem is marked as
experimental so dont expect to break uptime records while playing
with 1394 :-)

Kristian

