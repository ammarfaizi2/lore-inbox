Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136299AbRD2UYw>; Sun, 29 Apr 2001 16:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136327AbRD2UYn>; Sun, 29 Apr 2001 16:24:43 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:24838 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136334AbRD2UXi>; Sun, 29 Apr 2001 16:23:38 -0400
Message-ID: <3AEC7842.B6AB7663@transmeta.com>
Date: Sun, 29 Apr 2001 13:23:30 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Sony Memory stick format funnies...
In-Reply-To: <200104292018.WAA25250@cave.bitwizard.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff wrote:
> >
> > I doubt the kernel is seeing it without it being there (it doesn't have
> > much imagination.)  However, it may very well be there in a funny
> > manner.  You do realize, of course, that it's pretty much impossible for
> > us to help you answer that question without a complete dump of the
> > filesystem on hand, I hope?
> 
> Yes, I realize. That's why I gave the whole dump in the first Email.
> 
> These are all lines of 16 bytes that do not contain only zeroes or
> only 0xff's.
> 

I can't test kernel behaviour with a hexdump!  I think the first thing
you should do is dd your entire thing to a file, mount it loopback, and
see if the behaviour reoccurs or not using the file.  Then you may want
to consider posting the binary somewhere.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
